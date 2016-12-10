//
//  ViewController.m
//  RoundImage
//
//  Created by vee on 2016/12/10.
//  Copyright © 2016年 xman. All rights reserved.
//

#import "ViewController.h"
#import "UIimageView+Round.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIImageView* imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_imageView setShowActivityIndicatorView:YES];
    [_imageView round_setImageWithURL:[NSURL URLWithString:@"https://desktop.github.com/images/screens/mac/main.png"] placeholderImage:nil options:0 progress:nil completed:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
