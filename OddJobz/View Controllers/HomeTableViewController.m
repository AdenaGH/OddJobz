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
    //[Listing postListing];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
