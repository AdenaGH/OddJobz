//
//  ApplicantCell.h
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/19/21.
//

#import <UIKit/UIKit.h>
#import "Listing.h"
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplicantCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *applicantName;
@property (nonatomic, strong) Listing *listing;

-(void)showUser:(PFUser*)user;
@end

NS_ASSUME_NONNULL_END
