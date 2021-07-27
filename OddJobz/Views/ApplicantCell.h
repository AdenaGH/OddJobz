//
//  ApplicantCell.h
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/21/21.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplicantCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *applicantImage;

@property (strong, nonatomic) PFUser* user;
-(void)makeApplicants:(PFUser *)user;
@end

NS_ASSUME_NONNULL_END
