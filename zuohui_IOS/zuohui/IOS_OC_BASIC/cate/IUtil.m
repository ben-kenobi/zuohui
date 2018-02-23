//
//  IUtil.m
//Created by apple on 17/07/21.
//

#import "IUtil.h"
#import "objc/runtime.h"
#import <sys/sysctl.h>
#import <mach/mach.h>


@implementation IUtil
+(NSString *)getTimestamp{
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
}

+(void)broadcast:(NSString *)mes info:(NSDictionary *)info{
    [[NSNotificationCenter defaultCenter] postNotificationName:mes object:0 userInfo:info];
}
+(float)systemVersion{
    return  [[UIDevice currentDevice].systemVersion floatValue];
}
+(NSInteger)appVersion{
    NSString *appVersion=[IUtil appVersionStr];
    NSArray *charArr=[appVersion componentsSeparatedByString:@"."];
    NSInteger version_code=0;
    for (int i=0; i<charArr.count; i++) {
        version_code+=[[charArr objectAtIndex:i] integerValue]*(i==0?100:(i==1?10:1));
    }
    return version_code;
    //    return [iBundle.infoDictionary[(NSString *)kCFBundleVersionKey] integerValue];
}
+(NSString *)appVersionStr{
    return  (NSString *)iBundle.infoDictionary[@"CFBundleShortVersionString"];
}

+(NSArray *)prosWithClz:(Class)clz{
    unsigned int count;
    struct objc_property **pros=class_copyPropertyList(clz, &count);
    NSMutableArray *ary=[NSMutableArray array];
    for(int i=0;i<count;i++){
        struct objc_property *pro=pros[i];
        [ary addObject:[NSString stringWithUTF8String:property_getName(pro)]];
    }
    return ary;
}

+(id)setValues:(NSDictionary *)dict forClz:(Class)clz{
    NSArray *ary=[self prosWithClz:clz];
    id obj=[[clz alloc] init];
    for(NSString *key in ary){
        if(dict[key]){
            [obj setValue:dict[key] forKey:key];
        }
    }
    return obj;
}
+(void)setValues:(NSDictionary *)dict forObj:(NSObject *)obj{
    NSArray *ary=[self prosWithClz:obj.class];
    for(NSString *key in ary){
        if(dict[key]){
            [obj setValue:dict[key] forKey:key];
        }
    }
}



+(NSArray *)aryWithClz:(Class)clz fromFile:(NSString *)file{
    NSAssert(file!=0, @"[IUtil aryFromFile:file:] file is nil");
    NSAssert(clz!=0, @"[IUtil aryFromFile:file:] clz is nil");
    NSMutableArray *ary=[NSMutableArray array];
    for(NSDictionary *dict in [NSArray arrayWithContentsOfFile:file]){
        id obj=[[clz alloc] init];
        [obj setValuesForKeysWithDictionary:dict];
        [ary addObject:obj];
    }
    return ary;
}


+(void)get:(NSURL *)url cache:(int)cache callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    [[[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:url cachePolicy:cache timeoutInterval:15] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(callback)
                callback(data,response,error);
        });
        
    }] resume];
}

+(void)post:(NSURL *)url body:(NSString *)body callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15];
    
    req.HTTPMethod=@"POST";
  
    req.HTTPBody=[[body stringByReplacingPercentEscapesUsingEncoding:4] dataUsingEncoding:4];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(callback)
                callback(data,response,error);
        });
        
    }] resume];
    
}
//-----upload with data ------
+(void)upload:(NSData *)data name:(NSString *)name
     filename:(NSString *)filename toURL:(NSURL *)url setupReq:(void(^)(NSMutableURLRequest *req))setupReq callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    NSString *boundary=@"--------------1234566";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15];
    if(setupReq)
        setupReq(req);
    req.HTTPMethod=@"POST";
    [req setValue:[@"multipart/form-data; boundary=" stringByAppendingString:boundary] forHTTPHeaderField:@"Content-Type"];
    req.HTTPBody=[self uploadBodyWithBoundary:boundary data:data name:name filename:filename];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(callback)
                callback(data,response,error);
        });
        
    }] resume];
}

+(NSData *)uploadBodyWithBoundary:(NSString *)boundary data:(NSData *)data  name:(NSString *)name filename:(NSString *)filename{
    NSMutableData *mdata=[NSMutableData dataWithData:[self segWithBoundary:boundary data:data name:name filename:filename]];
    [mdata appendData:[self segOfEndingWithBoundary:boundary]];
    return mdata;
    
}

+(NSData *)segWithBoundary:(NSString *)boundary data:(NSData *)data  name:(NSString *)name filename:(NSString *)filename{
    NSMutableData *mdata=[NSMutableData dataWithData:[[NSString stringWithFormat:@"\r\n--%@\r\nContent-Disposition: form-data; name=%@; filename=%@\r\nContent-Type: %@\r\n\r\n",boundary,name,filename,@"application/octet-stream"] dataUsingEncoding:4]];
    [mdata appendData:data];
    return mdata;
}

//-----upload with filepath ------
+(void)uploadFile:(NSString *)file name:(NSString *)name
         filename:(NSString *)filename toURL:(NSURL *)url callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    NSString *boundary=@"--------------1234566";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15];
    
    req.HTTPMethod=@"POST";
    [req setValue:[@"multipart/form-data; boundary=" stringByAppendingString:boundary] forHTTPHeaderField:@"Content-Type"];
    req.HTTPBody=[self uploadBodyWithBoundary:boundary file:file name:name filename:filename];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(callback)
                callback(data,response,error);
        });
        
    }] resume];
}
+(NSData *)uploadBodyWithBoundary:(NSString *)boundary file:(NSString *)file  name:(NSString *)name filename:(NSString *)filename{
    NSMutableData *mdata=[NSMutableData dataWithData:[self segWithBoundary:boundary file:file name:name filename:filename]];
    [mdata appendData:[self segOfEndingWithBoundary:boundary]];
    return mdata;
    
}


//----multi--


+(void)multiUpload:(NSArray *)contents toURL:(NSURL *)url callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    NSString *boundary=@"--------------1234566";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15];
    
    req.HTTPMethod=@"POST";
    [req setValue:[@"multipart/form-data; boundary=" stringByAppendingString:boundary] forHTTPHeaderField:@"Content-Type"];
    req.HTTPBody=[self multiUploadBodyWithBoundary:boundary contents:contents];
    [req.HTTPBody writeToFile:@"/Users/apple/Desktop/con.txt" atomically:YES];
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(callback)
                callback(data,response,error);
        });
        
    }] resume];
}



+(NSData *)multiUploadBodyWithBoundary:(NSString *)boundary contents:(NSArray *)contents{
    NSMutableData *mdata=[NSMutableData data];
    for(int i=0;i<contents.count;i++){
        [mdata appendData:[self segWithBoundary:boundary dict:contents[i]]];
    }
    [mdata appendData:[self segOfEndingWithBoundary:boundary]];
    return mdata;
}


+(NSData *)segWithBoundary:(NSString *)boundary dict:(NSDictionary *)dict{
    if(dict[@"file"]){
        return [self segWithBoundary:boundary file:dict[@"file"] name:dict[@"name"] filename:dict[@"filename"]];
    }else{
        return [self segWithBoundary:boundary name:dict[@"name"] val:dict[@"value"]];
    }
}
+(NSData *)segOfEndingWithBoundary:(NSString *)boundary{
    return [[NSString stringWithFormat:@"\r\n--%@--",boundary ] dataUsingEncoding:4];
}

+(NSData *)segWithBoundary:(NSString *)boundary name:(NSString *)name val:(NSString *)val{
    return [NSData dataWithData:[[NSString stringWithFormat:@"\r\n--%@\r\nContent-Disposition: form-data; name=%@\r\n\r\n%@",boundary,name,val] dataUsingEncoding:4]];
    ;
}

+(NSData *)segWithBoundary:(NSString *)boundary file:(NSString *)file  name:(NSString *)name filename:(NSString *)filename{
    NSURLResponse *resp= [self synResponseByURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",file]]];
    if(!filename)
        filename=[resp suggestedFilename];
    NSMutableData *mdata=[NSMutableData dataWithData:[[NSString stringWithFormat:@"\r\n--%@\r\nContent-Disposition: form-data; name=%@; filename=%@\r\nContent-Type: %@\r\n\r\n",boundary,name,filename,resp.MIMEType] dataUsingEncoding:4]];
    ;
    
    [mdata appendData:[NSData dataWithContentsOfFile:file]];
    ;
    return mdata;
}


+(NSURLResponse *)synResponseByURL:(NSURL *)url{
    NSURLResponse *respon;
    [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:&respon error:0];
    return respon;
}

//----multi--

















//CUP & MEMORY
+ (NSInteger)availableMemory

{
    
    vm_statistics_data_t vmStats;
    
    mach_msg_type_number_t infoCount =HOST_VM_INFO_COUNT;
    
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               
                                               HOST_VM_INFO,
                                               
                                               (host_info_t)&vmStats,
                                               
                                               &infoCount);
    
    
    
    if (kernReturn != KERN_SUCCESS) {
        
        return NSNotFound;
        
    }
    
    
    
    return (vm_page_size *vmStats.free_count) ;
    
}

+ (NSInteger)usedMemory

{
    
    task_basic_info_data_t taskInfo;
    
    mach_msg_type_number_t infoCount =TASK_BASIC_INFO_COUNT;
    
    kern_return_t kernReturn =task_info(mach_task_self(),
                                        
                                        TASK_BASIC_INFO,
                                        
                                        (task_info_t)&taskInfo,
                                        
                                        &infoCount);
    
    
    
    if (kernReturn != KERN_SUCCESS
        
        ) {
        
        return NSNotFound;
        
    }
    
    
    
    return taskInfo.resident_size ;
    
}

+(double)curUsage{
    return [self usedMemory]*100.0/[self GetMemoryStatistics];
}





+ (NSInteger)GetMemoryStatistics {
    
    // Get Page Size
    int mib[2];
    unsigned long page_size;
    size_t len;
    
    mib[0] = CTL_HW;
    mib[1] = HW_PAGESIZE;
    len = sizeof(page_size);
    
    //    // 方法一: 16384
    //    int status = sysctl(mib, 2, &page_size, &len, NULL, 0);
    //    if (status < 0) {
    //        perror("Failed to get page size");
    //    }
    //    // 方法二: 16384
    //    page_size = getpagesize();
    // 方法三: 4096
    if( host_page_size(mach_host_self(), &page_size)!= KERN_SUCCESS ){
        perror("Failed to get page size");
    }
    printf("Page size is %ld bytes\n", page_size);
    
    // Get Memory Size
    mib[0] = CTL_HW;
    mib[1] = HW_MEMSIZE;
    long ram;
    len = sizeof(ram);
    if (sysctl(mib, 2, &ram, &len, NULL, 0)) {
        perror("Failed to get ram size");
    }
    printf("Ram size is %f MB\n", ram / (1024.0) / (1024.0));
    
    // Get Memory Statistics
    //    vm_statistics_data_t vm_stats;
    //    mach_msg_type_number_t info_count = HOST_VM_INFO_COUNT;
    vm_statistics64_data_t vm_stats;
    mach_msg_type_number_t info_count64 = HOST_VM_INFO64_COUNT;
    //    kern_return_t kern_return = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vm_stats, &info_count);
    kern_return_t kern_return = host_statistics64(mach_host_self(), HOST_VM_INFO64, (host_info64_t)&vm_stats, &info_count64);
    if (kern_return != KERN_SUCCESS) {
        printf("Failed to get VM statistics!");
    }
    
    double vm_total = vm_stats.wire_count + vm_stats.active_count + vm_stats.inactive_count + vm_stats.free_count;
    return vm_total;
//    double vm_wire = vm_stats.wire_count;
//    double vm_active = vm_stats.active_count;
//    double vm_inactive = vm_stats.inactive_count;
//    double vm_free = vm_stats.free_count;
//    double unit = (1024.0) * (1024.0);
    
//    NSLog(@"Total Memory: %f", vm_total * page_size / unit);
//    NSLog(@"Wired Memory: %f", vm_wire * page_size / unit);
//    NSLog(@"Active Memory: %f", vm_active * page_size / unit);
//    NSLog(@"Inactive Memory: %f", vm_inactive * page_size / unit);
//    NSLog(@"Free Memory: %f", vm_free * page_size / unit);

}



+(double)GetCpuUsage {
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    
    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0; // Mach threads
    
    basic_info = (task_basic_info_t)tinfo;
    
    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    if (thread_count > 0)
        stat_thread += thread_count;
    
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for (j = 0; j < thread_count; j++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return 0;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }
        
    } // for each thread
    
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    return tot_cpu;
    
//    NSLog(@"CPU Usage: %f \n", tot_cpu);
}
@end
