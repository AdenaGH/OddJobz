//
//  LoginViewController.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/13/21.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)registerUser {
    
    // Make new user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    newUser.jobsAccepted = 0;
    newUser.jobsPosted = 0;
    

    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (IBAction)loginButton:(id)sender {
    if ([self.usernameField.text isEqual:@""]) {
        NSLog(@"username field be empty");
        UIAlertController *userAlert = [UIAlertController alertControllerWithTitle:@"Missing Username"
                                                                            message:@"Please enter a username!"
                                                                            preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
                                                         }];
        
        // add the OK action to the alert controller
        [userAlert addAction:okAction];
        [self presentViewController:userAlert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    } else if ([self.passwordField.text isEqual:@""]) {
        UIAlertController *passwordAlert = [UIAlertController alertControllerWithTitle:@"Missing Password"
                                                                                   message:@"Please enter a password!"
                                                                            preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
                                                         }];
        // add the OK action to the alert controller
        [passwordAlert addAction:okAction];
        [self presentViewController:passwordAlert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
        
    } else {
        [self loginUser];
    }
}
- (IBAction)signUpButton:(id)sender {
    if ([self.usernameField.text isEqual:@""]) {
        NSLog(@"username field be empty");
        UIAlertController *userAlert = [UIAlertController alertControllerWithTitle:@"Missing Username"
                                                                                   message:@"Please enter a username!"
                                                                            preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
                                                         }];
        
        // add the OK action to the alert controller
        [userAlert addAction:okAction];
        [self presentViewController:userAlert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    } else if ([self.passwordField.text isEqual:@""]) {
        UIAlertController *passwordAlert = [UIAlertController alertControllerWithTitle:@"Missing Password"
                                                                                   message:@"Please enter a password!"
                                                                            preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
                                                         }];
        // add the OK action to the alert controller
        [passwordAlert addAction:okAction];
        [self presentViewController:passwordAlert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
        
    } else {
        [self registerUser];
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
