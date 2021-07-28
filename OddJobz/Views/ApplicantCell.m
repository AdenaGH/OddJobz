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

@end
