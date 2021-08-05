//
//  ApplicantCell.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/21/21.
//

#import "ApplicantCell.h"
#import "Parse/Parse.h"
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@implementation ApplicantCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void) makeApplicants: (PFUser *)user withListing:(nonnull Listing *)listing {
    if ([self.hireButton isSelected]) {
        [self.hireButton setUserInteractionEnabled:NO];
    }
    [user fetchIfNeeded];
    [user fetch];
    self.user = user;
    self.listing = listing;
    [listing fetch];
    [self.user.profileImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            self.applicantImage.image = [UIImage imageWithData:data];
        }
    }];
    self.nameLabel.text = user.username;
    if (self.user == self.listing.hire) {
        [self.hireButton setSelected:YES];
    }
}

//Two new buttons
- (IBAction)pressHire:(id)sender {
    self.listing.hire = self.user;
    [self.hireButton setSelected:YES];
    NSMutableArray *toDelete = [NSMutableArray array];
    NSMutableArray *newArray = self.listing.applicants;
    for (PFUser * user in self.listing.applicants) {
       if (user!= self.user)
           [toDelete addObject:user];
    }
    // Remove them
    [newArray removeObjectsInArray:toDelete];
    self.listing.applicants = newArray;
    BFTask *goodTask =[self.listing saveInBackground];
    [goodTask waitUntilFinished];
}

- (IBAction)markCompleted:(id)sender {
    //Doing this because I don't want the listing to be shown in the home screen anymore, but still be saved with the user
    self.listing.jobDone = YES;
    [self.listing saveInBackground];
    //self getpffilefromimage
    NSMutableArray * newArray = self.user.completedListings;;
    [newArray addObject:self.listing.category];
    self.user.completedListings = newArray;
    //self.user access
    BFTask *task = [self.user saveInBackground];
    [task waitUntilFinished];
    BFTask *task2 =[self.listing saveInBackground];
    [task2 waitUntilFinished];
}


@end
