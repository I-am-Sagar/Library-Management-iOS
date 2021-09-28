//
//  MyBooksManager.m
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021. 
//

#import "MyBooksManager.h"
#import "BookDetail.h"
#import "BooksDBManager.h"

static NSString *const issueKey = @"issues";

@interface MyBooksManager()

@property (nonatomic, strong) BooksDBManager* dbManager;

@end


@implementation MyBooksManager

static MyBooksManager *_sharedInstance = nil;

+(MyBooksManager *)shared {
    @synchronized([MyBooksManager class]) {
        if (!_sharedInstance)
            _sharedInstance = [[self alloc] init];
        return _sharedInstance;
    }
    return nil;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.dbManager = [[BooksDBManager alloc] initWithKey:issueKey];
    }
    return self;
}


-(void)issueWithDetailModel: (Book *)book {
    [self.dbManager addBook:book];
}


-(void)unissueWithDetailModel: (Book *)book {
    [self.dbManager removeBook:book];
}


-(NSArray *)issues {
    return [self.dbManager issues];
}


-(BOOL)contains: (Book *)book {
    for (Book *b in self.issues) {
        if ([b.isbn13 isEqualToString:book.isbn13]) return YES;
    }
    return NO;
}

@end
