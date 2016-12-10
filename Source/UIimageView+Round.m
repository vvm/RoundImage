//
//  UIimageView+Round.m
//  FaceFoto
//
//  Created by vee on 2016/12/10.
//  Copyright © 2016年 xman. All rights reserved.
//

#import "UIimageView+Round.h"

@interface RoundManager : NSObject <SDWebImageManagerDelegate>

@property (nonatomic, strong) NSMutableSet* roundImageURLList;

+ (instancetype) shareManager;
- (void)addRoundImageURL:(NSURL*)url;

@end

@implementation RoundManager

+ (instancetype)shareManager
{
    static RoundManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RoundManager alloc] init];
        NSAssert([SDWebImageManager sharedManager].delegate == nil, @"SDWebImageManager sharedManager already has a delegate");
        [SDWebImageManager sharedManager].delegate = manager;
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _roundImageURLList = [NSMutableSet set];
    }
    return self;
}

- (void)addRoundImageURL:(NSURL *)url
{
    // remember the url point to the image should circle
    [_roundImageURLList addObject:url];
}

- (BOOL)imageManager:(SDWebImageManager *)imageManager shouldDownloadImageForURL:(NSURL *)imageURL
{
    return YES;
}

- (UIImage *)imageManager:(SDWebImageManager *)imageManager transformDownloadedImage:(UIImage *)image withURL:(NSURL *)imageURL
{
    if (!image) {
        return image;
    }
    
    if (![_roundImageURLList containsObject:imageURL]) {
        return image;
    }
    
    return [RoundManager roundImage:image];
}

// circle image in AspectFit mode
+ (UIImage*)roundImage:(UIImage*)image
{
    CGSize originSize = image.size;
    CGFloat length = MIN(originSize.width, originSize.height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(length, length), NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // clip a circle
    CGContextSaveGState(context);
    CGContextAddPath(context, [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, length, length) cornerRadius:length / 2.0].CGPath);
    CGContextClip(context);
    [image drawInRect:CGRectMake((length - originSize.width) / 2.0, (length - originSize.height) / 2.0, originSize.width, originSize.height)];
    CGContextRestoreGState(context);
    UIImage* roundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundImage;
}

@end

@implementation UIImageView (Round)

- (void)round_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock
{
    [[RoundManager shareManager] addRoundImageURL:url];
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:progressBlock completed:completedBlock];
}

@end
