//
//  BookStoreClient.m
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021. 
//

#import "BookStoreClient.h"

#import "Book.h"
#import "BookDetail.h"

NSString *const Scheme = @"https";
NSString *const BaseURL = @"api.itbook.store";

@implementation BookStoreClient

static BookStoreClient *_sharedInstance = nil;

+(BookStoreClient *)shared {
    @synchronized([BookStoreClient class]) {
        if (!_sharedInstance)
            _sharedInstance = [[self alloc] init];
        return _sharedInstance;
    }
    return nil;
}

-(void)requestWithPath: (NSString *)path params: (NSDictionary *)params completion: (void (^)(id))completion {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:Scheme];
    [components setHost:BaseURL];
    for (NSString *key in params.allKeys) {
        [components setQuery: [NSString stringWithFormat:@"%@=%@", key, params[key]]];
    }
    [components setPath:path];
    NSURL *url = [components URL];
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError;
        id jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError || !jsonDictionaryOrArray) {
            NSLog(@"json error : %@", [jsonError localizedDescription]);
            completion(nil);
        } else {
            completion(jsonDictionaryOrArray);
        }
    }];
    [downloadTask resume];
}


-(void)requestNewAPIWithCompletion: (void (^)(NSArray *))completion {
    NSString *path = @"/1.0/new";
    [self requestWithPath:path params:@{} completion:^(id result) {
        if (result) {
            NSArray *books = [self convertToBookWithJSON: result[@"books"]];
            completion(books);
        } else {
            completion(@[]);
        }
    }];
}


-(void)requestSearchAPIWithQuery: (NSString *)query page: (NSNumber *)page completion: (void (^)(NSArray *))completion {
    NSString *path = @"/1.0/search";
    if (query) {
        path = [NSString stringWithFormat:@"%@/%@", path, query];
        if (page) {
            path = [NSString stringWithFormat:@"%@/%@", path, page];
        }
    }
    [self requestWithPath:path params:@{} completion:^(id result) {
        if (result) {
            NSArray *books = [self convertToBookWithJSON: result[@"books"]];
            completion(books);
        } else {
            completion(@[]);
        }
    }];
}


-(void)requestDetailBookAPIWithQuery: (NSString *)isbn13 completion: (void (^)(BookDetail *))completion {
    NSString *path = @"/1.0/books";
    if (isbn13) {
        path = [NSString stringWithFormat:@"%@/%@", path, isbn13];
    }
    
    [self requestWithPath:path params:@{} completion:^(id result) {
        if (result) {
            BookDetail *bookDetail = [[BookDetail alloc] initWithInfo: result];
            completion(bookDetail);
        } else {
            completion(nil);
        }
    }];
}


-(NSArray *)convertToBookWithJSON: (NSArray *)bookInfos {
    if (bookInfos) {
        NSMutableArray *books = [[NSMutableArray alloc] init];
        for (int i=0; i<bookInfos.count; i++) {
            NSDictionary *bookInfo = bookInfos[i];
            Book *book = [[Book alloc] initWithInfo: bookInfo];
            [books addObject:book];
        }
        return books;
    } else {
        return @[];
    }
}

@end
