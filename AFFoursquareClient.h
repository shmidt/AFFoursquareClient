//  FSClient.h
//
//  Created by Dmitry Shmidt on 11/24/12.
//  MIT license

#import "AFHTTPClient.h"
static NSString * const kFoursquareClientID = @"Your_Foursquare_Client_ID"
static NSString * const kFoursquareClientSecret = @"Your_Foursquare_Client_Secret"
static NSString * const kFoursquareVersion = @"20120520" //Date of the API 
static NSString * const kAPIBaseURLString = @"https://api.foursquare.com/v2/";
@interface AFFoursquareClient : AFHTTPClient
+ (AFFoursquareClient *)sharedClient;
- (void)exploreVenues:(void (^)(NSArray *venues))success inRadius:(int)radiusMeters coordinate:(CLLocationCoordinate2D)coordinate failure:(void (^)(NSError *error))failure;
@end
