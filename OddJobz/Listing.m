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

+ (void) postListing:(NSString *)title withDescription:(NSString *)descript andLocation:(NSString *)location andPrice:(NSString *)price andImage: ( UIImage * _Nullable )image {
    Listing *newListing = [Listing new];
    newListing.poster = [PFUser currentUser];
    newListing.image = [self getPFFileFromImage:image];
    newListing.postedAt = [NSDate date];
    newListing.jobTitle = title;
    newListing.jobDescription = descript;
    newListing.jobLocation = location;
    newListing.price = price;
    //NSInteger *jobsPosted = [newListing.poster.jobsPosted integerValue];
    
    //newListing.poster.jobsPosted += 1;
    
    [newListing saveInBackground];
}


+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
