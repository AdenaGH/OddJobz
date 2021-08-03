//
//  EditProfileViewController.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/23/21.
//

#import "EditProfileViewController.h"
#import "Parse/Parse.h"

@interface EditProfileViewController ()
//@property (strong, nonatomic) UIGestureRecognizer *tapper;
@property (strong, nonatomic) NSArray * strongsuits;
@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.strongsuits = @[@"Education", @"Tech", @"Handywork", @"Art", @"Cleaning"];
    self.strongsuitPicker.dataSource = self;
    self.strongsuitPicker.delegate = self;

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];

    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}
- (IBAction)pressPicEdit:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    

    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(void)dismissKeyboard
{
    [self.firstName resignFirstResponder];
    [self.lastName resignFirstResponder];
    [self.confirmPassword resignFirstResponder];
}
- (IBAction)pressSaveChanges:(id)sender {
    PFUser *curUser = [PFUser currentUser];
    if ([self.confirmPassword.text isEqual:curUser.username]) {
        UIImage *resizeImage = [self resizeImage:self.profileImage.image withSize:CGSizeMake(120, 120)];
        curUser.firstName = self.firstName.text;
        curUser.lastName = self.lastName.text;
        curUser.profileImage = [self getPFFileFromImage:resizeImage];
        curUser.strength = self.strongsuit.text;
        curUser.biography = self.bio.text;
        [curUser saveInBackground];
    }
}

-(PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    // check if image is not nil
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    // Do something with the images
    self.profileImage.image = originalImage;
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.strongsuits.count;
}
- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.strongsuits[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.strongsuit.text = self.strongsuits[row];
}

@end
