//
//  SignupVC.m
//  Library Management
//
//  Created by Udasi, Sagar on 24/09/2021.
//

#import "SignupVC.h"

@import Firebase;
@import FirebaseAuth;
@import FirebaseFirestore;

#define max(a, b) ((a) < (b) ? (b) : (a))


@interface SignupVC ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

- (IBAction)signup:(UIButton *)sender;
- (IBAction)viewLoginPage:(UIButton *)sender;

- (BOOL)validate;

@end


@implementation SignupVC

// ------------------------------------------ SYSTEM FUNCTIONS ---------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
}

// @viewDidLayoutSubviews: Centers the contents vertically, to make it look good on bigger screens like iPad.
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat tableViewHeight = self.tableView.frame.size.height;
    CGFloat contentHeight = self.tableView.contentSize.height;
    
    CGFloat centeringInset = (tableViewHeight - contentHeight)/2.0;
    CGFloat topInset = max(centeringInset, 0.0);
    
    [self.tableView setContentInset:UIEdgeInsetsMake(topInset, 0.0, 0.0, 0.0)];
}

// ----------------------------------------- HELPER FUNCTIONS -------------------------------------------

// @validate: A very basic validation check. *FUTURE IMPROVEMENTS.
- (BOOL) validate {
    if (_usernameTextField.text == nil || _emailTextField == nil || _passwordTextField == nil || _confirmPasswordTextField == nil) {
        return false;
    }
    NSString* password = _passwordTextField.text;
    NSString* confirmPassword = _confirmPasswordTextField.text;
    if (password != confirmPassword) {
        return false;
    }
    return true;
}


// ------------------------------------------ MAIN FUNCTIONS ----------------------------------------------

// @signup: Creates a new user based on the given details.
- (IBAction)signup:(UIButton *)sender {
    // If the fields entered are valid, proceed with the signup process.
    if ([self validate]) {
        NSString* emailID = _emailTextField.text;
        NSString* password = _passwordTextField.text;
        [[FIRAuth auth] createUserWithEmail:emailID password:password completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            // If there is an error in creating the user - alert, something went wrong.
            if (error != nil) {
                UIAlertController* wrong = [UIAlertController alertControllerWithTitle:@"Error" message:@"Something went wrong." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* okayButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [wrong addAction:okayButton];
                [self presentViewController:wrong animated:YES completion:nil];
            }
            // If no error occurs, add username to the firestore db and transition to the login page.
            else {
                FIRFirestore* defaultFirestore = [FIRFirestore firestore];
                [[defaultFirestore collectionWithPath:@"users"] addDocumentWithData:@{
                    @"username": self->_usernameTextField.text,
                } completion:nil];
                
                [self viewLoginPage:sender];
            }
        }];
    }
    // Else if the fields are not valid, alert user to check the inputs once again.
    else {
        UIAlertController* invalidInput = [UIAlertController alertControllerWithTitle:@"Error" message:@"Invalid Input. Please check your input once again." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okayButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [invalidInput addAction:okayButton];
        [self presentViewController:invalidInput animated:YES completion:nil];
    }
}


// @viewLoginPage: Navigates user to the login page to login to the main app.
- (IBAction)viewLoginPage:(UIButton *)sender {
    UITableViewController *loginVC = [self.storyboard  instantiateViewControllerWithIdentifier:@"LoginView"];
    [self.navigationController pushViewController:loginVC animated:true];
}


@end
