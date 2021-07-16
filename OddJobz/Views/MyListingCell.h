//
//  MyListingCell.h
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/16/21.
//

#import <UIKit/UIKit.h>
#import "Listing.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyListingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *listingImage;
@property (weak, nonatomic) IBOutlet UILabel *listingPrice;
@property (weak, nonatomic) IBOutlet UILabel *listingTitle;
@property (weak, nonatomic) IBOutlet UILabel *listingDescription;

@property (nonatomic, strong) Listing *listing;
-(void)showListing:(Listing *)listing;
@end

NS_ASSUME_NONNULL_END
