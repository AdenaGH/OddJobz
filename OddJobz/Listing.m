//
//  Listing.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/13/21.
//

#import "Listing.h"

@implementation Listing

@dynamic userID;
@dynamic postID;
@dynamic poster;
@dynamic postedAt;
@dynamic jobTitle;
@dynamic jobDescription;
@dynamic image;
@dynamic jobLocation;
@dynamic price;


+ (nonnull NSString *)parseClassName {
    return @"Listing";
}

+ (void) postListing:(NSString *)title withDescription:(NSString *)descript andLocation:(NSString *)location {
    Listing *newListing = [Listing new];
    newListing.poster = [PFUser currentUser];
    newListing.postedAt = [NSDate date];
    newListing.jobTitle = title;
    newListing.jobDescription = descript;
    newListing.jobLocation = location;
    
    [newListing saveInBackground];
}

@end
