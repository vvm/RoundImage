//
//  UIimageView+Round.h
//  FaceFoto
//
//  Created by vee on 2016/12/10.
//  Copyright © 2016年 xman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface UIImageView (Round)

- (void)round_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;

@end
