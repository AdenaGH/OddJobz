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
#import "LoginViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface HomeTableViewController ()  <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UISearchBarDelegate>
@property (strong, nonatomic) NSMutableArray *listings;
@property (strong, nonatomic) NSMutableArray *filteredListings;
@property (strong, nonatomic) UIRefreshControl *refreshCont;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property CLLocationManager *manager;

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    self.searchBar.delegate = self;
    //[self.manager requestWhenInUseAuthorization];
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.manager requestWhenInUseAuthorization];
    }
    [self.manager startUpdatingLocation];
    
    
    
    [self fetchListings];
    //self.filteredListings = self.listings;
    self.refreshCont = [[UIRefreshControl alloc] init];
    [self.refreshCont addTarget:self action:@selector(fetchListings) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshCont atIndex:0];
        
 
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.firstObject;
    if (location == nil) {
        NSLog(@"Help wanted");
        [self.manager stopUpdatingLocation];
    }
}
// Get info from database
- (void)fetchListings {
    PFQuery *query = [PFQuery queryWithClassName:@"Listing"];
    [query includeKey:@"poster"];
    [query includeKey:@"location"];
    //[query orderByDescending:@"createdAt"];
    [query whereKey:@"poster" notEqualTo:[PFUser currentUser]];



    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *listings, NSError *error) {
        if (listings != nil) {
            // do something with the array of object returned by the call
            self.listings = (NSMutableArray *) listings;
            self.filteredListings = [[NSMutableArray alloc] initWithArray:self.listings];

            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshCont endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.filteredListings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListingCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Listing *listing = self.filteredListings[indexPath.row];
    [cell setUserLocation: [PFGeoPoint geoPointWithLocation:self.manager.location]];
    [cell makeListing:listing];
    
    
    return cell;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //self.listings = self.filteredListings;
    //
    [self.filteredListings removeAllObjects];
    
    if([searchText isEqualToString:@""]||searchText==nil){
        self.filteredListings = self.listings;
        [self.tableView reloadData];
        return;
    } else {
        for (Listing *searchListing in self.listings) {
            NSRange rangeValue = [searchListing.jobDescription rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (rangeValue.length > 0) {
                [self.filteredListings addObject:searchListing];
            }
        }
    }
    
    [self.tableView reloadData];
 
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    self.filteredListings = self.listings;
    [self.searchBar resignFirstResponder];
    [self.tableView reloadData];
}

- (IBAction)logoutButtonPress:(id)sender {
    NSLog(@"Logout action called");

    //AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //UITabBarController *tabController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    //appDelegate.window.rootViewController = loginViewController;
    
    //[[UIApplication sharedApplication].keyWindow setRootViewController: tabController];
    [[UIApplication sharedApplication].keyWindow setRootViewController: loginViewController];
    loginViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    
    NSLog(@"Logout action finished");
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
        UINavigationController *nav = [segue destinationViewController];
        DetailsViewController *detailsView = (DetailsViewController *) nav.topViewController;
        detailsView.listing = clickedListing;
        
    }

}


@end
