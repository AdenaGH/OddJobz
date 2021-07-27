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
    [self.listing fetchIfNeeded];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchApplicants];
    
    self.refreshCont = [[UIRefreshControl alloc] init];
    [self.refreshCont addTarget:self action:@selector(fetchApplicants) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshCont atIndex:0];

}
- (void)fetchApplicants {
    [self.listing fetchIfNeeded];
    self.myApplicants = [[NSMutableArray alloc] initWithArray: self.listing.applicants];
}
#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.myApplicants.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ApplicantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplicantCell" forIndexPath:indexPath];
    
    // Configure the cell...
    PFUser *user = self.myApplicants[indexPath.row];
    [cell makeApplicants:user];
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
