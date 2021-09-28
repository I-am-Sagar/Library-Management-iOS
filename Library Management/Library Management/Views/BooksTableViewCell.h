//
//  BooksTableViewCell.h
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Book;
@interface BooksTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *isbn13Label;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
// Even though url is fetched in summarized book object, we aren't
// showing it on the library page. 
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

- (void)setBook: (Book *)book;

@end

NS_ASSUME_NONNULL_END
