//
//  BooksVC.m
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021. 
//

#import "BooksVC.h"
#import "BookDetailsVC.h"
#import "MyBooksManager.h"
#import "BooksTableView.h"
#import "Book.h"
#import "BooksTableViewCell.h"
#import "BookStoreClient.h"

@interface BooksVC () <DetailBookDelegate>

@property (weak, nonatomic) IBOutlet BooksTableView *mainTableView;
- (IBAction)gotoSearchView:(UIBarButtonItem *)sender;

@end


@implementation BooksVC

// ------------------------------------------ SYSTEM FUNCTIONS ---------------------------------------------

// @viewDidLoad: When the view has finished loading, it will call refresh.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTableView.detailBookDelegate = self;
    [self refresh:nil];
}

// @viewWillAppear: Creates a clickable effect on the tableview cell viz. a book here.
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexPath *indexPathForSelectedRow = self.mainTableView.indexPathForSelectedRow;
    if (indexPathForSelectedRow) {
        [self.mainTableView deselectRowAtIndexPath:indexPathForSelectedRow animated:YES];
    }
}

// ----------------------------------------- HELPER FUNCTIONS ----------------------------------------------

// @reloadNewAPI: A function from BookStoreClient.h which connects to the network and loads latest books as
//                feed. *FUTURE IMPROVEMENTS
-(void)reloadNewAPI {
    // start of network
    [[BookStoreClient shared] requestNewAPIWithCompletion:^(NSArray * _Nonnull books) {
        self.mainTableView.books = books;
        dispatch_async(dispatch_get_main_queue(), ^{
            // on main thread
            [self.mainTableView reloadData];
        });
    }];
}

// @reloadSearchAPIWithQuery: A function from BookStoreClient.h which connects to the network and loads books
//                            based on the query/search made by the user.
-(void)reloadSearchAPIWithQuery:(NSString *)query {
    if (!query) { return; }
    // start of network
    [[BookStoreClient shared] requestSearchAPIWithQuery:query page:@(1) completion:^(NSArray * _Nonnull books) {
        self.mainTableView.books = books;
        dispatch_async(dispatch_get_main_queue(), ^{
            // on main thread
            [self.mainTableView reloadData];
        });
    }];
}


// ------------------------------------------- MAIN FUNCTIONS ----------------------------------------------

// @refresh: If the view has loaded for the first time during app start up, it will call reloadNewAPI().
//           If we have been redirected from the search page, then we will have user query and it will
//           call reloadSearchAPIWithQuery.
- (IBAction)refresh:(UIBarButtonItem *)sender {
    if (self.query) {
        [self reloadSearchAPIWithQuery:self.query];
    } else {
        [self reloadNewAPI];
    }
}

// @prepareForSegue: Before transitioning to the BookDetails view, we store the selected book in the
//                   book property of BookDetailsVC. Thus, we are preparing for segueing.
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"gotoDetailBook"]) {
        Book *book = sender;
        BookDetailsVC *vc = (BookDetailsVC *)segue.destinationViewController;
        vc.book = book;
    }
}

// @segueWithBook: Once the segue is prepared, now the segue could be performed.
-(void)segueWithBook:(id<BookProtocol>)book {
    [self performSegueWithIdentifier:@"gotoDetailBook" sender:book];
}

// @gotoSearchView: The search button on the navigation pane will take to the SearchVC.
- (IBAction)gotoSearchView:(UIBarButtonItem *)sender {
    UIViewController* gotoSearchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
    [self.navigationController pushViewController:gotoSearchVC animated:TRUE];

}


@end
