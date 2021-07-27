//
//  TabBarController.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/27/21.
//

#import "TabBarController.h"
//#import "OddJobz-Swift.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer *leftToRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftToRightSwipeDidFire)];
    leftToRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tabBarController.tabBar addGestureRecognizer:leftToRightGesture];

    UISwipeGestureRecognizer *rightToLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightToLeftSwipeDidFire)];
    rightToLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.tabBarController.tabBar addGestureRecognizer:rightToLeftGesture];
    // Do any additional setup after loading the view.
}
- (void)leftToRightSwipeDidFire {
    UITabBar *tabBar = self.tabBarController.tabBar;
    NSInteger index = [tabBar.items indexOfObject:tabBar.selectedItem];
    if (index > 0) {
        self.tabBarController.selectedIndex = index - 1;
    } else {
        return;
    }
}
- (void)rightToLeftSwipeDidFire {
    UITabBar *tabBar = self.tabBarController.tabBar;
    NSInteger index = [tabBar.items indexOfObject:tabBar.selectedItem];
    if (index < tabBar.items.count - 1) {
        self.tabBarController.selectedIndex = index + 1;
    } else {
        return;
    }
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
