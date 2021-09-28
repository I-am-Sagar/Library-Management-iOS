//
//  ImageViewer.m
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021. 
//

#import "ImageViewer.h"
#import "ImageCacheManager.h"

@implementation UIImageView (Cache)

-(void)loadImageWithURL:(NSURL *)url {
    [self setupNilImage];
    
    UIImage *image = [[ImageCacheManager shared] getCachedImageForKey:url.absoluteString];
    if (image) {
        [self setNonnilImage: image];
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData* data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            [[ImageCacheManager shared] cacheImage:image forKey:url.absoluteString];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    [self setNonnilImage: image];
                } else {
                    [self setupNilImage];
                }
                
            });
        });
    }
}

-(void)setNonnilImage:(UIImage *)image {
    self.image = image;
    self.backgroundColor = [UIColor clearColor];
}

-(void)setupNilImage {
    self.image = nil;
    self.backgroundColor = [UIColor grayColor];
}

@end
