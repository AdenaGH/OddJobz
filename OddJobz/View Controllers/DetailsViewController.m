//
//  DetailsViewController.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/14/21.
//

#import "DetailsViewController.h"

#import "Parse/Parse.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *listingTitle;
@property (weak, nonatomic) IBOutlet UILabel *listingDistance;
@property (weak, nonatomic) IBOutlet UILabel *listingPoster;
@property (weak, nonatomic) IBOutlet UILabel *listingSkill;
@property (weak, nonatomic) IBOutlet UILabel *listingDescription;
@property (weak, nonatomic) IBOutlet UILabel *listingPrice;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self.listing);
    self.listingTitle.text = self.listing.jobTitle;
    self.listingDescription.text = self.listing.jobDescription;
    self.listingPoster.text = self.listing.poster.username;
    self.listingPrice.text = self.listing.price;
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
