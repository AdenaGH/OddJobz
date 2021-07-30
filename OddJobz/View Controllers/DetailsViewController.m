//
//  DetailsViewController.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/14/21.
//

#import "DetailsViewController.h"
#import "Listing.h"

#import "Parse/Parse.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *listingTitle;
@property (weak, nonatomic) IBOutlet UILabel *listingPoster;
@property (weak, nonatomic) IBOutlet UILabel *listingSkill;
@property (weak, nonatomic) IBOutlet UILabel *listingDescription;
@property (weak, nonatomic) IBOutlet UILabel *listingPrice;
@property (weak, nonatomic) IBOutlet UIImageView *listingImageView;
@property (strong, nonatomic) NSArray *chanceMessages;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self.listing);
    self.chanceMessages = @[@"Odds are very high that you'll be selected for the job!",
                            @"Odds are high that you'll be selected for the job!",
                            @"Odds are decent that you'll get the job.",
                            @"Odds are fair that you'll get the job.",
                            @"Yikes! The odds are not in your favor for this job."];
    [self.listing.poster.profileImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            self.detailImageView.image = [UIImage imageWithData:data];
        }
    }];
    self.listingSkill.text = @"Apply to the job to check your odds";
    self.listingTitle.text = self.listing.jobTitle;
    self.listingDescription.text = self.listing.jobDescription;
    self.listingPoster.text = self.listing.poster.username;
    self.listingPrice.text = self.listing.price;
    [self.listing.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            self.listingImageView.image = [UIImage imageWithData:data];
        }
    }];

}
- (IBAction)acceptJob:(id)sender {
    UIAlertController *userAlert = [UIAlertController alertControllerWithTitle:@"Accept Job"
                                                                        message:@"Are you sure you want to accept this job?"
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    // create a cancel action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"No"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle cancel response here. Doing nothing will dismiss the view.
                                                      }];
    // add the cancel action to the alertController
    [userAlert addAction:cancelAction];

    // create an OK action
    PFUser *curUser = [PFUser currentUser];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Yes"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * _Nonnull action) {
                                        NSMutableArray * testArray = self.listing.applicants;
                                        [testArray addObject:curUser];
        [self.listing saveInBackground];
        //NSLog(@"%lu", (unsigned long)testArray.count);
        [curUser.appliedListings addObject:self.listing];
                                        self.listing.applicants = testArray;
        [curUser saveInBackground];
                                        
        //NSLog(@"%@", self.listing.applicants);
                                                     }];
    // add the OK action to the alert controller
    [userAlert addAction:okAction];
    [self presentViewController:userAlert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
    
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
