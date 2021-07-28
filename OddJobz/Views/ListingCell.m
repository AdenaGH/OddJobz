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


-(void) determineChance {
    float chance = 100;
    //Chance where # of applicants is the variable
//    if (self.listing.applicants.count >= 20) {
//        chance -= 20;
//        //Upcoming edge case: When you apply, the count changes to 1, but you're the only 1 so there's kinda still a 100% chance of being picked, but if there's 1 applicant that ISN'T you, it would be different
//    } else if (self.listing.applicants.count == 0) {
//        chance = chance;
//    } else {
//        for (PFUser * user in self.listing.applicants) {
//            chance -=1;
//        }
//    }
    // Chance for distance
    int dX = 20;
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
    //self.listing.postedAt since
    NSTimeInterval timeSince = [[NSDate date] timeIntervalSinceDate:self.listing.postedAt]/86400; //converting seconds to days idk
    int timeInDays = timeSince;
    if (timeInDays <= 3) {
        chance = chance;
    } else if (timeInDays > 60) {
        chance -=20;
    } else {
        while (timeInDays >3){
            timeInDays -=3;
            chance -=1;
        }
    }
    
    //Chance based on whether or not the category matches your strength
    if (![self.listing.category isEqual: [PFUser currentUser].strength]) {
        chance -=20;
    }
    
    //Chance based on experience
    
    
    
    
}

@end
