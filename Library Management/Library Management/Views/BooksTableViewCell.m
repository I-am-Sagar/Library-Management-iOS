//
//  BooksTableViewCell.m
//  Library Management
//
//  Created by Udasi, Sagar on 24/04/2021.
//

#import "BooksTableViewCell.h"
#import "Book.h"
#import "ImageViewer.h"

@implementation BooksTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

// @setBook: From the data in the Book object, fill the fields of the tableview cell.
- (void)setBook: (id<BookProtocol>)book {
    self.titleLabel.text = book.title;
    self.subtitleLabel.text = book.subtitle;
    self.isbn13Label.text = [NSString stringWithFormat:@"%@", book.isbn13];
    if ([book.price isEqual:@"$0.00"]) {
        self.priceLabel.text = @"FREE";
    } else {
        self.priceLabel.text = book.price;
    }
    self.urlLabel.text = book.url;
    NSURL *imageURL = [NSURL URLWithString:book.imageURL];
    if (imageURL) {
        [self.leftImageView loadImageWithURL:imageURL];
    }
}

@end
