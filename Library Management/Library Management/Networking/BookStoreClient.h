//
//  BookStoreClient.h
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BookDetail;
@interface BookStoreClient : NSObject

+(BookStoreClient *)shared;

-(void)requestNewAPIWithCompletion: (void (^)(NSArray *))completion;
-(void)requestSearchAPIWithQuery: (NSString *)query page: (NSNumber *)page completion: (void (^)(NSArray *))completion;
-(void)requestDetailBookAPIWithQuery: (NSString *)isbn13 completion: (void (^)(BookDetail *))completion;

@end

NS_ASSUME_NONNULL_END
