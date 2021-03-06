//
//  ListingCell.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/13/21.
//

#import "ListingCell.h"
#import "Listing.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "MapKit/MapKit.h"
#import "DateTools/DateTools.h"

@implementation ListingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) makeListing:(Listing *)listing {
    self.listing = listing;
    self.listingTitle.text = listing.jobTitle;
    self.listingDescription.text = listing.jobDescription;
    self.listingPrice.text = listing.price;
    CLLocation *newUserLocation = [[CLLocation alloc] initWithLatitude: self.userLocation.latitude longitude:self.userLocation.longitude];
    CLLocation *newListingLocation = [[CLLocation alloc] initWithLatitude: self.listing.location.latitude longitude:self.listing.location.longitude];
    double distance = [newUserLocation distanceFromLocation:newListingLocation];
    double distanceNumber =(distance/1609.34);
    self.distanceNumber = [[NSNumber alloc] initWithDouble:distanceNumber];
    self.listingDistance.text = [[NSString stringWithFormat:@"%.2f", distanceNumber] stringByAppendingString:@" mi."];
    [self.listing.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            self.listingImage.image = [UIImage imageWithData:data];
        }
    }];
}

-(void)giveUserLocation:(CLLocation *)userLocation {
    
}
@end
