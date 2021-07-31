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
@property (weak, nonatomic) IBOutlet UILabel *strengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *theEditButton;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.user == nil) {
        self.user = [PFUser currentUser];
    }
    
    self.usernameLabel.text = self.user.username;
    self.wholeNameLabel.text = [self.user.firstName stringByAppendingString:self.user.lastName];
    self.strengthLabel.text = self.user.strength;
    self.bioLabel.text = self.user.biography;
    [self.user.profileImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            self.profileImageView.image = [UIImage imageWithData:data];
        }
    }];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
}
- (IBAction)tappedRightButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];

    [self.tabBarController setSelectedIndex:selectedIndex + 1];
}

- (IBAction)tappedLeftButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];

    [self.tabBarController setSelectedIndex:selectedIndex - 1];
}


@end
