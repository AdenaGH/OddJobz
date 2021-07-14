//
//  ListingCell.h
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/13/21.
//

#import <UIKit/UIKit.h>
#import "Listing.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *listingImage;
@property (weak, nonatomic) IBOutlet UILabel *listingPrice;
@property (weak, nonatomic) IBOutlet UILabel *listingTitle;
@property (weak, nonatomic) IBOutlet UILabel *listingDescription;
@property (weak, nonatomic) IBOutlet UILabel *listingDistance;

@property (strong, nonatomic) Listing *listing;
-(void)makeListing:(Listing *)listing;
@end

NS_ASSUME_NONNULL_END
