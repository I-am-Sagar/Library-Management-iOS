//
//  BookDetail.h
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021.
//

#import <Foundation/Foundation.h>
#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookDetail : NSObject<NSCoding, NSSecureCoding, BookProtocol>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *isbn13;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *url;
// Extra fields in Detailed format of Book:
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *rating;
@property (nonatomic, strong) NSString *authors;
@property (nonatomic, strong) NSString *publisher;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *pages;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *isbn10;
@property (nonatomic, strong) NSString *error;


- (instancetype) initWithInfo: (NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
