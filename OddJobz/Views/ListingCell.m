//
//  ListingCell.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/13/21.
//

#import "ListingCell.h"
#import "Listing.h"

@implementation ListingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) makeListing:(Listing *)listing {
    self.listing = listing;
    
    self.listingTitle.text = listing.jobTitle;
    self.listingDescription.text = listing.jobDescription;
    self.listingPrice.text = listing.price;
    
    [self.listing.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            self.listingImage.image = [UIImage imageWithData:data];
        }
    }];
}
@end
