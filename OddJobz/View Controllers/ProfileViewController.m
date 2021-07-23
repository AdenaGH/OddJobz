//
//  ProfileViewController.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/23/21.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *jobsDoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobsAvailableLabel;
@property (weak, nonatomic) IBOutlet UILabel *wholeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = [PFUser currentUser];
    self.usernameLabel.text = self.user.username;
    self.wholeNameLabel.text = [self.user.firstName stringByAppendingString:self.user.lastName];
    self.profileImageView.image = self.user.profileImage;
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
