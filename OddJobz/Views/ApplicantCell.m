//
//  ApplicantCell.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/21/21.
//

#import "ApplicantCell.h"

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
    self.user = user;
    self.listing = listing;
    [listing fetch];
    [user fetchIfNeeded];
    [user fetch];
    [self.user.profileImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            self.applicantImage.image = [UIImage imageWithData:data];
        }
    }];
    self.nameLabel.text = user.username;


}

//Two new buttons
- (IBAction)pressHire:(id)sender {
    self.listing.hire = self.user;
    
    
    
    
    NSMutableArray *toDelete = [NSMutableArray array];
    for (PFUser * user in self.listing.applicants) {
       if (user!= self.user)
           [toDelete addObject:user];
    }
    // Remove them
    [self.listing.applicants removeObjectsInArray:toDelete];
    [self.listing saveInBackground];
    
    
    
    
    
//    for (PFUser * user in [self.listing.applicants reverseObjectEnumerator]) {
//        if (user != self.user) {
//            //remove other applicants from list
//            [self.listing.applicants removeObject:user];
//        }
//    }
    //Listing = [self.listing copy]
    [self.listing saveInBackground];
    //[[PFUser currentUser] saveInBackground];
}

- (IBAction)markCompleted:(id)sender {
    //Doing this because I don't want the listing to be shown in the home screen anymore, but still be saved with the user
    Listing * listingCopy = [[Listing alloc] init];
    [self.user.completedListings addObject: [listingCopy manualCopy:self.listing]];
    [listingCopy saveInBackground];
    
    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                NSLog(@"AYOOOOOOOOO");
            } else {
                NSLog(@"No errors foun d");
            }
    }];
    //[listingCopy saveInBackground];
    //[[PFUser currentUser] saveInBackground];
    [self.user saveInBackground];
    //[self.listing deleteInBackground];
    
}


@end
