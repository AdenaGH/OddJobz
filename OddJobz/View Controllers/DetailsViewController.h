//
//  DetailsViewController.h
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/14/21.
//

#import <UIKit/UIKit.h>
#import "Listing.h"
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (nonatomic, strong) Listing *listing;
@end

NS_ASSUME_NONNULL_END
