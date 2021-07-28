//
//  Listing.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/13/21.
//

#import "Listing.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "MapKit/MapKit.h"
#import "Parse/Parse.h"
#import "DateTools/DateTools.h"

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
@dynamic applicants;
@dynamic fakeProp;
@dynamic location;
@dynamic jobChance;
@dynamic category;
+ (nonnull NSString *)parseClassName {
    return @"Listing";
}

+ (void) postListing:(NSString *)title withDescription:(NSString *)descript andLocation:(NSString *)location andPrice:(NSString *)price andImage: ( UIImage * _Nullable )image andListingLocation: (CLLocation *) listingLocation andCategory:(NSString *)category{
    Listing *newListing = [Listing new];
    newListing.poster = [PFUser currentUser];
    newListing.image = [self getPFFileFromImage:image];
    newListing.postedAt = [NSDate date];
    newListing.jobTitle = title;
    newListing.jobDescription = descript;
    newListing.jobLocation = location;
    newListing.price = price;
    newListing.category = category;
    newListing.fakeProp = @"Hey lol";
    newListing.applicants = [NSMutableArray new];
    //NSValue *locationValue = [NSValue valueWithMKCoordinate:listingLocation.coordinate];
    //newListing.location = locationValue;
    //PFGeoPoint *geoLocation =
    newListing.location = [PFGeoPoint geoPointWithLatitude:listingLocation.coordinate.latitude longitude:listingLocation.coordinate.longitude];
    [newListing.poster.availableListings addObject:newListing];
    //newListing.location = [PFGeoPoint geoPointWithLocation:listingLocation];
    
    //NSInteger *jobsPosted = [newListing.poster.jobsPosted integerValue];
    
    //newListing.poster.jobsPosted += 1;
    
    [newListing saveInBackground];
    [newListing.poster saveInBackground];
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
