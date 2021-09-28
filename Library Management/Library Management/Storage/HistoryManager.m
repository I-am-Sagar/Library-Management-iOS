//
//  HistoryManager.m
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021. 
//

#import "HistoryManager.h"
#import "BookDetail.h"
#import "BooksDBManager.h"

static NSString *const historyKey = @"history";

@interface HistoryManager()

@property (nonatomic, strong) BooksDBManager* dbManager;

@end


@implementation HistoryManager

static HistoryManager *_sharedInstance = nil;

+(HistoryManager *)shared {
    @synchronized([HistoryManager class]) {
        if (!_sharedInstance)
            _sharedInstance = [[self alloc] init];
        return _sharedInstance;
    }
    return nil;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.dbManager = [[BooksDBManager alloc] initWithKey:historyKey];
    }
    return self;
}


-(void)readWithDetailModel: (Book *)bookDetail {
    [self.dbManager addBook:bookDetail];
}


-(NSArray *)issues {
    return [self.dbManager issues];
}


@end
