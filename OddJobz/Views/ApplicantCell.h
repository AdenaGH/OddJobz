//
//  ApplicantCell.h
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/21/21.
//

#import <UIKit/UIKit.h>
#import "Listing.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplicantCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) Listing*listing;

@end

NS_ASSUME_NONNULL_END
