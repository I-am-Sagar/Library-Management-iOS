//
//  ImageCacheManager.h
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021. 
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageCacheManager : NSObject

+(ImageCacheManager *)shared;
- (void)cacheImage:(UIImage*)image forKey:(NSString*)key;
- (UIImage*)getCachedImageForKey:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
