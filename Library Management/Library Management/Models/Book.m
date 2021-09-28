//
//  Book.m
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021.
//

#import "Book.h"

@implementation Book

// @initWithInfo: The data fetched from API is in form of NSDictionary. We need to instantiate our
//                Book object using that info. This function does that.
- (instancetype) initWithInfo: (NSDictionary *)info {
    self = [super init];
    if(self) {
        NSLog(@"_init: %@", self);
        if (info[@"title"]) self.title = info[@"title"];
        if (info[@"subtitle"]) self.subtitle = info[@"subtitle"];
        if (info[@"image"]) self.imageURL = info[@"image"];
        if (info[@"isbn13"]) self.isbn13 = info[@"isbn13"];
        if (info[@"price"]) self.price = info[@"price"];
        if (info[@"url"]) self.url = info[@"url"];
    }
    return self;
}

// NSCoder is an interface that helps saving data on the disk in an encoded format.
// This is useful when we want to retrieve data back from the disk when logged in later.
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.subtitle forKey:@"subtitle"];
    [encoder encodeObject:self.imageURL forKey:@"imageURL"];
    [encoder encodeObject:self.isbn13 forKey:@"isbn13"];
    [encoder encodeObject:self.price forKey:@"price"];
    [encoder encodeObject:self.url forKey:@"url"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if(self = [super init]) {
        self.title = [decoder decodeObjectOfClass:[NSString class] forKey:@"title"];
        self.subtitle = [decoder decodeObjectOfClass:[NSString class] forKey:@"subtitle"];
        self.imageURL = [decoder decodeObjectOfClass:[NSString class] forKey:@"imageURL"];
        self.isbn13 = [decoder decodeObjectOfClass:[NSString class] forKey:@"isbn13"];
        self.price = [decoder decodeObjectOfClass:[NSString class] forKey:@"price"];
        self.url = [decoder decodeObjectOfClass:[NSString class] forKey:@"url"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
