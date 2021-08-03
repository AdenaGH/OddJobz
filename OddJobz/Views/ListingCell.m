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
    [self determineChance];
}

-(void)giveUserLocation:(CLLocation *)userLocation {
    
}
-(void) determineChance {
    //Chance where # of applicants is the variable
    float chance = 100;
    // Chance for distance
    int dX = 25;
    int distance = [self.distanceNumber intValue] - 10;
    //distance = 40
    if ([self.distanceNumber intValue] <= 10) {
        chance = chance;
    } else {
        while (dX > 0 && distance > 0) {
            chance -=1;
            dX -=1;
            distance -=1;
        }
    }
    //Chance based on listing age
    NSTimeInterval timeSince = [[NSDate date] timeIntervalSinceDate:self.listing.postedAt]/86400; //converting seconds to days
    int timeInDays = timeSince;
    if (timeInDays <= 3) {
        chance = chance;
    } else if (timeInDays > 70) {
        chance -=25;
    } else {
        while (timeInDays >3){
            timeInDays -=3;
            chance -=1;
        }
    }
    //Chance based on whether or not the category matches your strength
    PFUser *currentUser = [PFUser currentUser];
    if (![self.listing.category isEqual: currentUser.strength]) {
        chance -=25;
    }
    //Chance based on experience
    chance -=25; //They earn these instead of starting out with all
    if (currentUser.completedListings.count <5) {
        chance += 5; //To make it fair for new users, dont penalize for not having completed many jobs
    } else {
        if (chance < 100) {
            for (Listing *listing in currentUser.completedListings) {
                if ([listing.category isEqual:currentUser.strength] ) {
                    chance +=1;
                } else {
                    chance +=0.25;
                }
            }
        }
    }
    self.listing.jobChance = [[NSNumber alloc] initWithFloat:chance];
}


@end
