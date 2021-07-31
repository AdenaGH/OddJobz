//
//  MyListingsTableViewController.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/15/21.
//

#import "MyListingsTableViewController.h"
#import "Parse/Parse.h"
#import "Listing.h"
#import "MyListingCell.h"
//#import "ApplicantCell.h"
#import "ApplicantsTableViewController.h"


@interface MyListingsTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *myListings;
@property (strong, nonatomic) UIRefreshControl *refreshCont;


@end

@implementation MyListingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    [self fetchListings];
    
    self.refreshCont = [[UIRefreshControl alloc] init];
    [self.refreshCont addTarget:self action:@selector(fetchListings) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshCont atIndex:0];
    
    
 
}
// Get info from database
- (void)fetchListings {
    PFQuery *query = [PFQuery queryWithClassName:@"Listing"];
    [query includeKey:@"poster"];
    [query includeKey:@"applicants"];
    [query includeKey:@"profileImage"];
    [query whereKey:@"poster" equalTo:[PFUser currentUser]];



    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *listings, NSError *error) {
        if (listings != nil) {
            // do something with the array of object returned by the call
            self.myListings = (NSMutableArray *) listings;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshCont endRefreshing];
    }];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
}

- (IBAction)tappedRightButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];

    [self.tabBarController setSelectedIndex:selectedIndex + 1];
}

- (IBAction)tappedLeftButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];

    [self.tabBarController setSelectedIndex:selectedIndex - 1];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myListings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyListingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyListingCell" forIndexPath:indexPath];
    
     //Configure the cell...
    Listing *listing = self.myListings[indexPath.row];
    [cell showListing:listing ];
    //[self performSegueWithIdentifier:@"applicantsSegue" sender:cell];
    return cell;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqual:@"applicantsSegue"]) {
        //[self.tableView reloadData];
        MyListingCell *clickedCell = (MyListingCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:clickedCell];
        Listing *clickedListing = self.myListings[indexPath.row];
        //[self.tableView reloadData];
        UINavigationController *nav = [segue destinationViewController];
        ApplicantsTableViewController *applicantsView = (ApplicantsTableViewController *) nav.topViewController;
        applicantsView.listing = clickedListing;
    }
    }




@end
