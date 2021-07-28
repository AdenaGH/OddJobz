//
//  ListingCell.h
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/13/21.
//

#import <UIKit/UIKit.h>
#import "Listing.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "Parse/Parse.h"
NS_ASSUME_NONNULL_BEGIN

@interface ListingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *listingImage;
@property (weak, nonatomic) IBOutlet UILabel *listingPrice;
@property (weak, nonatomic) IBOutlet UILabel *listingTitle;
@property (weak, nonatomic) IBOutlet UILabel *listingDescription;
@property (weak, nonatomic) IBOutlet UILabel *listingDistance;
@property (strong, nonatomic) PFGeoPoint *userLocation;
@property (strong, nonatomic) NSNumber *distanceNumber;

@property (strong, nonatomic) Listing *listing;
-(void)makeListing:(Listing *)listing;
-(void)giveUserLocation:(CLLocation *)userLocation;
@end

NS_ASSUME_NONNULL_END
