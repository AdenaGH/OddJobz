//
//  EditProfileViewController.h
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/23/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditProfileViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *strongsuit;
@property (weak, nonatomic) IBOutlet UIImageView* profileImage;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UIPickerView *strongsuitPicker;
@property (weak, nonatomic) IBOutlet UITextView *bio;

@end

NS_ASSUME_NONNULL_END
