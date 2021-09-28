//
//  HistoryVC.m
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021.
//

#import "HistoryVC.h"
#import "BooksTableView.h"
#import "HistoryManager.h"
#import "BookDetailsVC.h"
#import "BookDetail.h"


@interface HistoryVC () <DetailBookDelegate>

@property (weak, nonatomic) IBOutlet BooksTableView *mainTableView;

@end


@implementation HistoryVC

// ------------------------------------------- SYSTEM FUNCTIONS ----------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTableView.detailBookDelegate = self;
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadIssuedBooks];
}

// ------------------------------------------- MAIN FUNCTIONS -------------------------------------------------

// @reloadIssuedBooks: Same logic as MyBooks, only diff being we fetch the books from HistoryManager instead of
//                     MyBooks manager.
-(void)reloadIssuedBooks {
    self.mainTableView.books = [[HistoryManager shared] issues];
    [self.mainTableView reloadData];
}

// @prepareForSegue: When a book item is clicked on History panel, it redirects to the Details view. So again,
//                   we need to store the book clicked to the details view before we segue.
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"gotoDetailBook"]) {
        Book *book = sender;
        BookDetailsVC *vc = (BookDetailsVC *)segue.destinationViewController;
        vc.book = book;
    }
}

// @segueWithBook: The function that performs the segue.
-(void)segueWithBook:(id<BookProtocol>)book {
    [self performSegueWithIdentifier:@"gotoDetailBook" sender:book];
}

@end
