//
//  BookDetailsVC.h
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021. 
//

#import <UIKit/UIKit.h>
#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@class BookDetail;
@interface BookDetailsVC : UIViewController

@property (nonatomic, strong) Book *book;
@property (nonatomic, strong) BookDetail *bookDetail;

@end

NS_ASSUME_NONNULL_END
