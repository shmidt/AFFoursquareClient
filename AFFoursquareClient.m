//  FSClient.m
//
//  Created by Dmitry Shmidt on 11/24/12.
//  MIT license
#import "AFFoursquareClient.h"
#import "AFJSONRequestOperation.h"

@implementation AFFoursquareClient
+ (AFFoursquareClient *)sharedClient {
    static AFFoursquareClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFFoursquareClient alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];

    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
//    [self setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        NSLog(@"changed %d", status);
//        //your code here
//    }];
    return self;
}

- (void)exploreVenues:(void (^)(NSArray *venues))success inRadius:(int)radiusMeters coordinate:(CLLocationCoordinate2D)coordinate failure:(void (^)(NSError *error))failure{
    [self getPath:@"venues/explore" parameters:@{
     @"limit": @"10",
     @"client_id":kFoursquareClientID,
     @"client_secret":kFoursquareClientSecret,
     @"radius":@(radiusMeters).stringValue,
     @"ll":[NSString stringWithFormat:@"%g,%g",coordinate.latitude, coordinate.longitude],
     @"v":kFoursquareVersion
     } success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSArray *items = responseObject[@"response"][@"groups"][0][@"items"];
         if (success)
         {
             success(items);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}
@end
