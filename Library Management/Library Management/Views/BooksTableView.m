//
//  BooksTableView.m
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021.
//

#import "BooksTableView.h"
#import "BooksTableViewCell.h"
#import "Book.h"

@interface BooksTableView ()

@end


@implementation BooksTableView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

// Populating the BooksTableView using 'books' array.

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BooksTableViewCell"];
    if (cell) {
        BooksTableViewCell *bookCell = (BooksTableViewCell *)cell;
        [bookCell setBook:self.books[[indexPath row]]];
    } else {
        cell = [[UITableViewCell alloc] init];
    }
    return cell;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.books ? self.books.count : 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"select - %ld", indexPath.row);
    if (self.detailBookDelegate) {
        [self.detailBookDelegate segueWithBook:self.books[indexPath.row]];
    }
}

@end
