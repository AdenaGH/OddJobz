//
//  ComposeViewController.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/13/21.
//

#import "ComposeViewController.h"
#import "Listing.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)pressShare:(id)sender {
    [Listing postListing];
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