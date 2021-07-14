//
//  HomeTableViewController.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/13/21.
//

#import "HomeTableViewController.h"
#import "Parse/Parse.h"
#import "Listing.h"
#import "ListingCell.h"
#import "DetailsViewController.h"

@interface HomeTableViewController ()  <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *listings;
@property (strong, nonatomic) UIRefreshControl *refreshCont;


@end

@implementation HomeTableViewController

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
    //[query includeKey:@"author"];
    //[query orderByDescending:@"createdAt"];


    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *listings, NSError *error) {
        if (listings != nil) {
            // do something with the array of object returned by the call
            self.listings = (NSMutableArray *) listings;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshCont endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.listings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListingCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Listing *listing = self.listings[indexPath.row];
    [cell makeListing:listing ];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqual:@"detailsSegue"]) {
        [self.tableView reloadData];
        ListingCell *clickedCell = (ListingCell *)sender;
        Listing *clickedListing = clickedCell.listing;
        [self.tableView reloadData];
        DetailsViewController *detailsView = [segue destinationViewController];
        detailsView.listing = clickedListing;
        
    }

}


@end
