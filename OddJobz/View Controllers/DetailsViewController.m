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
@property (strong, nonatomic) NSNumber *permChance;

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
                            @"Yikes! The odds are not in your favor for this job.",
                            @"Apply to the job to check your odds"];
    [self.listing.poster.profileImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            self.detailImageView.image = [UIImage imageWithData:data];
        }
    }];
    if (self.permChance >= 90) {
        
    }
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
    [self determineChance];
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
        if (testArray.count==0) {
                                                [testArray addObject:curUser];
        } else {
            for (PFUser* user in testArray) {
                if ([user.appliedListings objectForKey:self.listing] >= self.permChance) {
                    [testArray insertObject:curUser atIndex:[self.listing.applicants indexOfObject:user]];
                    break;
                } else {
                    [testArray addObject:curUser];
                }
            }
        }
                                                self.listing.applicants = testArray;
                                                [self.listing saveInBackground];
                                                     }];
    NSMutableDictionary *tempDict = curUser.appliedListings;
    [tempDict setObject:self.permChance forKey:self.listing];
    curUser.appliedListings = tempDict;
    [curUser saveInBackground];
//    NSMutableArray * testArray2 = curUser.appliedListings;
//                                            [testArray2 addObject:self.listing];
//                                           curUser.appliedListings = testArray2;
//                                            [curUser saveInBackground];
    // add the OK action to the alert controller
    [userAlert addAction:okAction];
    [self presentViewController:userAlert animated:YES completion:^{
    }];
}

-(void) determineChance {
    //Chance where # of applicants is the variable
    float chance = 100;
    // Chance for distance
    int dX = 25;
    int distance = [self.distanceNumber intValue] - 10;
    //distance = 40
    if ([self.distanceNumber intValue] <= 10) {
        chance = chance;
    } else {
        while (dX > 0 && distance > 0) {
            chance -=1;
            dX -=1;
            distance -=1;
        }
    }
    //Chance based on listing age
    NSTimeInterval timeSince = [[NSDate date] timeIntervalSinceDate:self.listing.postedAt]/86400; //converting seconds to days
    int timeInDays = timeSince;
    if (timeInDays <= 3) {
        chance = chance;
    } else if (timeInDays > 70) {
        chance -=25;
    } else {
        while (timeInDays >3){
            timeInDays -=3;
            chance -=1;
        }
    }
    //Chance based on whether or not the category matches your strength
    PFUser *currentUser = [PFUser currentUser];
    if (![self.listing.category isEqual: currentUser.strength]) {
        chance -=25;
    }
    //Chance based on experience
    chance -=25; //They earn these instead of starting out with all
    if (currentUser.completedListings.count <5) {
        chance += 5; //To make it fair for new users, dont penalize for not having completed many jobs
    } else {
        if (chance < 100) {
            for (Listing *listing in currentUser.completedListings) {
                if ([listing.category isEqual:currentUser.strength] ) {
                    chance +=1;
                } else {
                    chance +=0.25;
                }
            }
        }
    }
    self.permChance = [[NSNumber alloc] initWithFloat:chance];
}


@end
