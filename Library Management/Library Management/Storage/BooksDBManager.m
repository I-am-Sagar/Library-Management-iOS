//
//  BooksDBManager.m
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021. 
//

#import "BooksDBManager.h"
#import "Book.h"

@interface BooksDBManager()

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSMutableArray *_issues;

@end


@implementation BooksDBManager

- (instancetype)initWithKey:(NSString *)key {
    self = [super init];
    if (self) {
        self.key = key;
    }
    return self;
}


-(NSMutableArray *)issues {
    if (!self._issues) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:self.key];
        NSArray *storedIssues = @[];
        if (!data) {
            [self saveWithIssues:storedIssues];
        } else {
            NSSet *classes = [NSSet setWithObjects:[NSArray class], [Book class], nil];
            storedIssues = [NSKeyedUnarchiver unarchivedObjectOfClasses:classes fromData:data error:nil];
        }
        self._issues = [NSMutableArray arrayWithArray:storedIssues];
    }
    return self._issues;
}


-(void)saveWithIssues:(NSMutableArray *)issues {
    self._issues = issues;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:issues requiringSecureCoding:YES error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:self.key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void)addBook:(Book *)model {
    NSMutableArray *issues = [self issues];
    for (Book *book in issues) {
        if (book.isbn13 == model.isbn13) {return;}
    }
    [issues addObject:model];
    [self saveWithIssues:issues];
}


-(void)removeBook:(Book *)model {
    NSMutableArray *issues = [self issues];
    for (Book *book in issues) {
        if (book.isbn13 == model.isbn13) {
            [issues removeObject:book];
            break;
        }
    }
    [self saveWithIssues:issues];
}

@end
