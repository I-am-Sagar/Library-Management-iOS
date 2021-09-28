//
//  LoginVC.m
//  Library Management
//
//  Created by Udasi, Sagar on 24/09/2021.
//

#import "LoginVC.h"

@import Firebase;

#define max(a, b) ((a) < (b) ? (b) : (a))


@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)login:(UIButton *)sender;
- (IBAction)forgotPassword:(UIButton *)sender;
- (IBAction)showPass:(UIButton *)sender;
- (IBAction)viewSignupPage:(UIButton *)sender;
- (IBAction)googleLogin:(UIButton *)sender;
- (IBAction)facebookLogin:(UIButton *)sender;

- (BOOL)validate;

@end


@implementation LoginVC

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

// ----------------------------------------- HELPER FUNCTIONS ----------------------------------------------

// @validate: A very basic validation check. *FUTURE IMPROVEMENTS.
- (BOOL) validate {
    if (_emailTextField.text == nil || _passwordTextField.text == nil) {
        return false;
    }
    return true;
}

// ------------------------------------------- MAIN FUNCTIONS ----------------------------------------------

// @login: Functionality that logs the user in.
- (IBAction)login:(UIButton *)sender {
    // If user has filled all the details properly, continue with login process.
    if ([self validate]) {
        [[FIRAuth auth] signInWithEmail:self->_emailTextField.text password:self->_passwordTextField.text completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            // If login error occurs, alert - something went wrong!
            if (error != nil) {
                UIAlertController* wrong = [UIAlertController alertControllerWithTitle:@"Error" message:@"Something went wrong." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* okayButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [wrong addAction:okayButton];
                [self presentViewController:wrong animated:YES completion:nil];
            }
            // If there is no error, transition to the main app page.
            else {
                UINavigationController *mainApp = [self.storyboard instantiateViewControllerWithIdentifier:@"MainApp"];
                [self.navigationController pushViewController:mainApp animated:TRUE];
            }
        }];
    }
    // If user has not filled the details properly, alert - please check the input once again.
    else {
        UIAlertController* invalidInput = [UIAlertController alertControllerWithTitle:@"Error" message:@"Invalid Input. Please check your input once again." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okayButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [invalidInput addAction:okayButton];
        [self presentViewController:invalidInput animated:YES completion:nil];
    }
}


// @showPass: Toggles the visibility of the password text.
- (IBAction)showPass:(UIButton *)sender {
    _passwordTextField.secureTextEntry = !_passwordTextField.secureTextEntry;
}


// @viewSignupPage: Navigates user to the Signup page to create new account.
- (IBAction)viewSignupPage:(UIButton *)sender {
    UITableViewController *signupVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SignupVC"];
    [self.navigationController pushViewController:signupVC animated:true];
}


// @forgotPassword: Functionality for the user to reset the password. (NOT IMPLEMENTED BECAUSE THIS WILL REQUIRE ONE MORE VIEW). *FUTURE IMPROVEMENTS.
- (IBAction)forgotPassword:(UIButton *)sender {
    // Do nothing as of now
}


// @facebookLogin: Logs in using the facebook account. *FUTURE IMPROVEMENTS.
- (IBAction)facebookLogin:(UIButton *)sender {
    // Do nothing as of now
}


// @googleLogin: Logs in using the gmail account. *FUTURE IMPROVEMENTS.
- (IBAction)googleLogin:(UIButton *)sender {
    // Do nothing as of now
}


@end
