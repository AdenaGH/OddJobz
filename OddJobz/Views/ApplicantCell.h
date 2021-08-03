//
//  ApplicantCell.h
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/21/21.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Listing.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplicantCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *applicantImage;
@property (weak, nonatomic) IBOutlet UIButton *hireButton;
@property (weak, nonatomic) IBOutlet UIButton *completedButton;
@property (strong, nonatomic) PFUser* user;
@property (strong, nonatomic) Listing* listing;
@property (strong, nonatomic) UITableView *tableView;
-(void)makeApplicants:(PFUser *)user withListing: (Listing*) listing;
@end

NS_ASSUME_NONNULL_END
