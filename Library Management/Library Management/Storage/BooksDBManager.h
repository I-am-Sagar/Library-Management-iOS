//
//  BooksDBManager.h
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021. 
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Book;
@interface BooksDBManager : NSObject

-(instancetype)initWithKey:(NSString *)key;
-(NSMutableArray *)issues;
-(void)saveWithIssues:(NSArray *) issues;
-(void)addBook:(Book *)model;
-(void)removeBook:(Book *)model;

@end

NS_ASSUME_NONNULL_END
