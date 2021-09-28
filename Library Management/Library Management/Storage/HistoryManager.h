//
//  HistoryManager.h
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021. 
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Book;
@interface HistoryManager : NSObject

+(HistoryManager *)shared;

-(void)readWithDetailModel: (Book *)bookDetail;
-(NSArray *)issues;

@end

NS_ASSUME_NONNULL_END
