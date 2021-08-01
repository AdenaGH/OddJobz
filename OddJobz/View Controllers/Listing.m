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
@dynamic hire;
@dynamic jobDone;

+ (nonnull NSString *)parseClassName {
    return @"Listing";
}

- (void) postListing:(NSString *)title withDescription:(NSString *)descript andLocation:(NSString *)location andPrice:(NSString *)price andImage: ( UIImage * _Nullable )image andListingLocation: (CLLocation *) listingLocation andCategory:(NSString * _Nonnull)category{
    self.poster = [PFUser currentUser];
    self.image = [self getPFFileFromImage:image];
    self.postedAt = [NSDate date];
    self.jobTitle = title;
    self.jobDescription = descript;
    self.jobLocation = location;
    self.price = price;
    self.fakeProp = @"Hey lol";
    self.applicants = [NSMutableArray new];
    self.category = category;
    self.location = [PFGeoPoint geoPointWithLatitude:listingLocation.coordinate.latitude longitude:listingLocation.coordinate.longitude];
    //[self.poster.availableListings addObject:self];
    
    //Saves to database
    [self saveInBackground];
    [self.poster saveInBackground];
    self.jobDone = NO;
}


- (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
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

-(id) copyWithZone: (NSZone *) zone
{
        Listing *listingCopy = [[Listing allocWithZone: zone] init];

    [listingCopy postListing:self.jobTitle withDescription:self.jobDescription andLocation:self.location andPrice:self.price andImage:self.image andListingLocation:self.location andCategory:self.category];
        return listingCopy;
}

-(Listing*) manualCopy: (Listing *) listing {
    Listing *listingCopy = [[Listing alloc] init];
    [listingCopy postListing:listing.jobTitle withDescription:listing.jobDescription andLocation:self.location andPrice:self.price andImage:self.image andListingLocation:self.location andCategory:self.category];
    [listingCopy saveInBackground];
    return listingCopy;
}



@end
