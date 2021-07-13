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


+ (nonnull NSString *)parseClassName {
    return @"Listing";
}

+ (void) postListing {
    Listing *newListing = [Listing new];
    newListing.poster = [PFUser currentUser];
    newListing.postedAt = [NSDate date];
    newListing.jobTitle = @"Plumbing";
    
    [newListing saveInBackground];
}

@end
