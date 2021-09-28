//
//  Book.h
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BookProtocol <NSObject, NSCoding, NSSecureCoding>

-(NSString *)title;
-(NSString *)subtitle;
-(NSString *)imageURL;
-(NSString *)isbn13;
-(NSString *)price;
-(NSString *)url;

@end


@interface Book : NSObject<BookProtocol>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *isbn13;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *url;

- (instancetype) initWithInfo: (NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
