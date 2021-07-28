//
//  Listing.h
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/13/21.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
//NS_ASSUME_NONNULL_BEGIN

@interface Listing : PFObject<PFSubclassing>
@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *poster;
@property (nonatomic, strong) NSDate *postedAt;
@property (nonatomic, strong) NSString *jobDescription;
@property (nonatomic, strong) NSString *jobTitle;
@property (nonatomic,strong) NSString *price;
@property (nonatomic, strong) NSString *jobLocation;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) NSMutableArray *applicants;
@property (nonatomic,strong) NSString *fakeProp;
@property (nonatomic, strong) PFGeoPoint *location;
@property (nonatomic, strong) NSNumber* jobChance;
@property (nonatomic,strong) NSString *category;
@property (nonatomic, strong) PFUser *hire;
@property (nonatomic, assign) BOOL jobDone;
//@property (nonatomic, strong) NSNumber* jobDistance;

+ (void) postListing:(NSString *)title withDescription:(NSString *)descript andLocation:(NSString *)location andPrice:(NSString *)price andImage:( UIImage * _Nullable )image andListingLocation: (CLLocation *_Nonnull) listingLocation andCategory: (NSString*_Nonnull) category;

@end

//NS_ASSUME_NONNULL_END
