//
//  ApplicantsTableViewController.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/21/21.
//

#import "ApplicantsTableViewController.h"
#import "ApplicantCell.h"
#import "ProfileViewController.h"

@interface ApplicantsTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *myApplicants;
@property (strong, nonatomic) UIRefreshControl *refreshCont;

@end

@implementation ApplicantsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.listing saveInBackground];
    [self.listing fetchIfNeeded];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchApplicants];
    self.refreshCont = [[UIRefreshControl alloc] init];
    [self.refreshCont addTarget:self action:@selector(fetchApplicants) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshCont atIndex:0];
    [self.tableView reloadData];
}

- (void)fetchApplicants {
    [self.listing fetchIfNeeded];
    self.myApplicants = [[NSMutableArray alloc] initWithArray: self.listing.applicants];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myApplicants.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ApplicantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplicantCell" forIndexPath:indexPath];
    // Configure the cell...
    PFUser *user = self.myApplicants[indexPath.row];
    [user saveInBackground];
    [cell makeApplicants:user withListing: self.listing];
    cell.tableView = self.tableView;
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqual:@"appliedSegue"]) {
        [self.tableView reloadData];
        ApplicantCell *clickedCell = (ApplicantCell *)sender;
        PFUser *user = clickedCell.user;
        //[self.tableView reloadData];
        UINavigationController *nav = [segue destinationViewController];
        ProfileViewController *profileView = (ProfileViewController *) nav.topViewController;
        profileView.user = user;
    }
}


@end
