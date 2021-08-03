//
//  AppDelegate.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/12/21.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"
@import GoogleMaps;
@import GooglePlaces;
#import <GooglePlaces/GooglePlaces.h>
#import <GoogleMaps/GoogleMaps.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ParseClientConfiguration *config = [ParseClientConfiguration  configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"PQc67wby1UbuP5iMuC0sGstDsG5JpA2pE64Kk06O";
        configuration.clientKey = @"dLO6WrF1N19lV8y2jN17EsJuvb8sbqaSytelZUZn";
        configuration.server = @"https://parseapi.back4app.com";
    }];
    [Parse initializeWithConfiguration:config];
    [GMSServices provideAPIKey:@"AIzaSyDjrOwvk1wpw18YhfsF4FTcFtG_nRLWqKE"];
    [GMSPlacesClient provideAPIKey:@"AIzaSyDjrOwvk1wpw18YhfsF4FTcFtG_nRLWqKE"];
    return YES;
}
#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
