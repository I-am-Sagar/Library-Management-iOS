//
//  BooksTableView.h
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021.
//

#import <UIKit/UIKit.h>
#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DetailBookDelegate;
@interface BooksTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak, nullable) id <DetailBookDelegate> detailBookDelegate;
@property (atomic, strong) NSArray *books;

@end

NS_ASSUME_NONNULL_END

@protocol DetailBookDelegate <NSObject>
-(void)segueWithBook: (id<BookProtocol> _Nullable)book;
@end
