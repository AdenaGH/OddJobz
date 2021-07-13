//
//  Listing.h
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/13/21.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
NS_ASSUME_NONNULL_BEGIN

@interface Listing : PFObject<PFSubclassing>
@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *poster;
@property (nonatomic, strong) NSDate *postedAt;
@property (nonatomic, strong) NSString *jobDescription;
@property (nonatomic, strong) NSString *jobTitle;
@property (nonatomic, strong) PFFileObject *image;

@end

NS_ASSUME_NONNULL_END
