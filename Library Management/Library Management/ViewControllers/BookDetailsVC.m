//
//  BookDetailsVC.m
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021. 
//

#import "BookDetailsVC.h"
#import "ImageViewer.h"
#import "BookStoreClient.h"
#import "MyBooksManager.h"
#import "HistoryManager.h"
#import "BookDetail.h"

#import <SafariServices/SafariServices.h>

@interface BookDetailsVC ()

@property (nonatomic, strong) UIBarButtonItem *issueLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *isbn13Label;
@property (weak, nonatomic) IBOutlet UILabel *pagesLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *linkButton;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UILabel *isbn10Label;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end


@implementation BookDetailsVC

// ------------------------------------------ SYSTEM FUNCTIONS ---------------------------------------------


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    if (!self.bookDetail) {
        [self reloadBook];
        [self reloadDetailBookAPIWithISBN13:self.book.isbn13];
        [[HistoryManager shared] readWithDetailModel:self.book];
    } else {
        [self reloadDetailBook];
    }
}

// ----------------------------------------- HELPER FUNCTIONS -----------------------------------------------

// @setupUI: Creates the Issue button on the navigation pane and attaches tapIssue() function with it.
//           Then it updates the title of the issue button based on whether the book is already issued or not.
-(void)setupUI {
    self.issueLabel = [[UIBarButtonItem alloc] initWithTitle:@"Issue" style:UIBarButtonItemStylePlain target:self action:@selector(tapIssue:)];
    [self.navigationItem setRightBarButtonItem:self.issueLabel animated:NO];
    [self updateIssueTitle];
}

// @tapIssue: If the books is already issued, it unissues it. Or else, issues it. For this it uses functions
//            from MyBooksManager.h.
-(void)tapIssue:(id)sender {
    if (![[MyBooksManager shared] contains:self.book]) {
        [[MyBooksManager shared] issueWithDetailModel:self.book];
    } else {
        [[MyBooksManager shared] unissueWithDetailModel:self.book];
    }
    [self updateIssueTitle];
}

// @updateIssueTitle: Based on whether the book is issued or not, it updates the title of the issue label.
-(void)updateIssueTitle {
    if ([[MyBooksManager shared] contains:self.book]) {
        [self.issueLabel setTitle:@"Return"];
    } else {
        [self.issueLabel setTitle:@"Issue"];
    }
}

// @reloadBook: By the time the book gets loaded on the BookDetails view, we update the book fields as 'loading...'
//              and whatever data we have in Book model.
-(void)reloadBook {
    self.titleLabel.text = self.book.title;
    self.subtitleLabel.text = self.book.subtitle;
    self.priceLabel.text = self.book.price;
    self.isbn13Label.text = [NSString stringWithFormat:@"%@", self.book.isbn13];
    self.pagesLabel.text = @"loading...";
    self.descriptionLabel.text = @"loading...";
    [self.linkButton setTitle:@"loading..." forState:UIControlStateNormal];
    self.yearLabel.text = @"loading...";
    self.publisherLabel.text = @"loading...";
    self.authorsLabel.text = @"loading...";
    self.languageLabel.text = @"loading...";
    self.isbn10Label.text = @"loading...";
    self.ratingLabel.text = @"loading...";
}

// @reloadDetailBook: Once the data is loaded/fetched, the detail view is updated accordingly. This function is
//                    called by reloadDetailBookAPIWithISBN13 function.
-(void)reloadDetailBook {
    if (!self.bookDetail) return;
    self.titleLabel.text = self.bookDetail.title;
    self.subtitleLabel.text = self.bookDetail.subtitle;
    self.priceLabel.text = self.bookDetail.price;
    self.isbn13Label.text = self.bookDetail.isbn13;
    self.pagesLabel.text = self.bookDetail.pages;
    self.descriptionLabel.text = self.bookDetail.desc;
    [self.linkButton setTitle:self.bookDetail.url forState:UIControlStateNormal];
    self.yearLabel.text = self.bookDetail.year;
    self.publisherLabel.text = self.bookDetail.publisher;
    self.authorsLabel.text = self.bookDetail.authors;
    self.languageLabel.text = self.bookDetail.language;
    self.isbn10Label.text = self.bookDetail.isbn10;
    self.ratingLabel.text = self.bookDetail.rating;
    NSURL *url = [NSURL URLWithString:self.bookDetail.imageURL];
    if (url) {
        [self.mainImageView loadImageWithURL:url];
    }
}

// ------------------------------------------- MAIN FUNCTIONS ----------------------------------------------

// @reloadDetailBookAPIWithISBN13: Using the BookStoreClient.h function, requestDetailBookAPIWithQuery, it fetches
//                                 the details of a book using ISBN13 value and then reloads the BookDetails view.
-(void)reloadDetailBookAPIWithISBN13: (NSString *)isbn13 {
    // start of network
    [[BookStoreClient shared] requestDetailBookAPIWithQuery:isbn13 completion:^(BookDetail * _Nonnull result) {
        self.bookDetail = result;
        dispatch_async(dispatch_get_main_queue(), ^{
            // on main thread
            [self reloadDetailBook];
        });
    }];
}

// @tapLink: When the link on the details page is tapped, it redirects user to the safari and the link is opened.
- (IBAction)tapLink:(id)sender {
    // self.bookDetail.url
    NSURL *url = [NSURL URLWithString:self.bookDetail.url];
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url configuration:nil];
    // safariVC.delegate = self;
    [self.navigationController presentViewController:safariVC animated:YES completion:nil];
}

@end
