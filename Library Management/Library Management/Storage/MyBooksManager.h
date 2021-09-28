//
//  MyBooksManager.h
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021. 
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Book;
@interface MyBooksManager : NSObject

+(MyBooksManager *)shared;

-(void)issueWithDetailModel: (Book *)book;
-(void)unissueWithDetailModel: (Book *)book;
-(NSArray *)issues;
-(BOOL)contains: (Book *)book;

@end

NS_ASSUME_NONNULL_END
