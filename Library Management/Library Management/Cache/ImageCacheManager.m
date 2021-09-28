//
//  ImageCacheManager.m
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021. 
//

#import "ImageCacheManager.h"

@interface ImageCacheManager ()

@property (nonatomic, strong) NSCache *cache;

@end

@implementation ImageCacheManager

static ImageCacheManager *_sharedInstance = nil;

+(ImageCacheManager *)shared {
    @synchronized([ImageCacheManager class]) {
        if (!_sharedInstance)
            _sharedInstance = [[self alloc] init];
        return _sharedInstance;
    }
    return nil;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.cache = [[NSCache alloc] init];
    }
    return self;
}

- (void)cacheImage:(UIImage*)image forKey:(NSString*)key {
    [self.cache setObject:image forKey:key];
}

- (UIImage*)getCachedImageForKey:(NSString*)key {
    return [self.cache objectForKey:key];
}

@end
