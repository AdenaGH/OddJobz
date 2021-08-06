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
@property (strong, nonatomic) NSMutableArray *allListings;
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
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.manager requestWhenInUseAuthorization];
    }
    [self.manager startUpdatingLocation];
    [self fetchListings];
    [self makeUserUpdates];
    self.refreshCont = [[UIRefreshControl alloc] init];
    [self.refreshCont addTarget:self action:@selector(fetchListings) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshCont atIndex:0];
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
}

- (IBAction)tappedRightButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    [self.tabBarController setSelectedIndex:selectedIndex + 1];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.firstObject;
    if (location == nil) {
        [self.manager stopUpdatingLocation];
    }
}
// Get info from database
- (void)fetchListings {
    PFQuery *query = [PFQuery queryWithClassName:@"Listing"];
    [query includeKey:@"poster"];
    [query includeKey:@"location"];
    [query includeKey:@"applicants"];
    [query includeKey:@"jobDone"];
    [query whereKey:@"poster" notEqualTo:[PFUser currentUser]];
    [query whereKey:@"jobDone" equalTo:[NSNumber numberWithBool:NO]];
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
-(void)makeUserUpdates {
    //__block NSMutableArray *tempArray = [NSMutableArray new];
    PFQuery *query2 = [PFQuery queryWithClassName:@"Listing"];
    [query2 includeKey:@"objectId"];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray *listings, NSError *error) {
        if (listings != nil) {
            // do something with the array of object returned by the call
            self.allListings = (NSMutableArray*)listings;
            PFUser *curUser = [PFUser currentUser];
            [curUser fetchInBackground];
            for (NSString* listingID in curUser.appliedListings.allKeys) {
                for (Listing *listing in self.allListings) {
                    [listing fetchIfNeededInBackground];
                    if ([listing.objectId isEqual: listingID] && listing.jobDone == YES) {
                        NSMutableArray * newArray = [NSMutableArray new];
                        NSString * completedCategory = [[NSString alloc] initWithString:listing.category];
                        [newArray addObject:completedCategory];
                        curUser.completedListings = newArray;
                        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithDictionary:curUser.appliedListings];
                        [tempDict removeObjectForKey:listingID];
                        curUser.appliedListings = tempDict;
                        [curUser saveInBackground];
                    }
                }
                
            }
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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [[UIApplication sharedApplication].keyWindow setRootViewController: loginViewController];
    loginViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
}

-(void)updateCompletedListings {
    for (Listing * listing in [PFUser currentUser].appliedListings) {
        if (listing.jobDone) {
            Listing *newListing = [Listing new];
            [newListing postListing:listing.jobTitle withDescription:listing.jobDescription andLocation:listing.jobLocation andPrice:listing.price andImage:listing.image andListingLocation:listing.location andCategory:listing.category];
            
        }
    }
}

#pragma mark - Navigation

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
        detailsView.distanceNumber = clickedCell.distanceNumber;
    }
}
@end
