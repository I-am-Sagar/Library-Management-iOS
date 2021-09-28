//
//  ImageViewer.h
//  Library Management
//
//  Created by Udasi, Sagar on 27/09/2021. 
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView(Cache)

-(void)loadImageWithURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
