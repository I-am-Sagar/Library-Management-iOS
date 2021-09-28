//
//  SearchVC.m
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021. 
//

#import "SearchVC.h"
#import "BooksVC.h"


@interface SearchVC () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *topSearchBar;

@end


@implementation SearchVC

// ------------------------------------------ SYSTEM FUNCTIONS ---------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topSearchBar.delegate = self;
}

// ------------------------------------------- MAIN FUNCTIONS ----------------------------------------------

// @prepareForSegue: Before seguing to the Books view, we need to store the searchtext/query in the query
//                   property of BooksVC. This is the preparation before seguing.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)query {
    if ([segue.identifier isEqualToString:@"gotoBooks"]) {
        BooksVC *vc = (BooksVC *)segue.destinationViewController;
        vc.query = query;
    }
}

// @searchBarSearchButtonClicked: When the search bar's search button is clicked, it performs segue to the
//                                BooksVC.
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSLog(@"%@", searchBar.text);
    [self performSegueWithIdentifier:@"gotoBooks" sender:searchBar.text];
}

@end
