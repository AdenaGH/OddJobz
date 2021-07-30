//
//  LoginViewController.h
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/13/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (nonatomic, assign, unsafe_unretained, readwrite) BOOL publicWriteAccess;

@end

NS_ASSUME_NONNULL_END
