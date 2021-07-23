//
//  ProfileViewController.h
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/23/21.
//

#import <UIKit/UIKit.h>
#import "Listing.h"
#import "Parse/Parse.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (strong, nonatomic) PFUser *user;
@end

NS_ASSUME_NONNULL_END
