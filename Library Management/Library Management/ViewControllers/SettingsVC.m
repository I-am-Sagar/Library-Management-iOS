//
//  SettingsVC.m
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/21.
//

#import "SettingsVC.h"

@interface SettingsVC ()

@property NSMutableArray* settings;

@end


@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.settings = [NSMutableArray arrayWithObjects:@"Change Your Username",@"Change Your Password", @"Clear History", @"Delete Your Account", nil];
}

// ------------------------------------------- MAIN FUNCTIONS -------------------------------------------------

// A very basic TableView, put as a placeholder. Functionalities is pending. *FUTURE IMPROVEMENTS. 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settings.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.settings objectAtIndex:indexPath.row];
    return cell;
}


@end
