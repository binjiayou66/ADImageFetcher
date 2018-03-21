//
//  BViewController.m
//  ADMonitorPlatform
//
//  Created by Andy on 06/02/2018.
//  Copyright © 2018 Andy. All rights reserved.
//

#import "BViewController.h"
#import "UIImage+ADCache.h"
#import "ADImageCacheManager.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *names = @[@"reba.png", @"a.jpg", @"b.jpg", @"c.jpg", @"d.jpg"];
    for (int i = 0; i < names.count; i++) {
        CGFloat width = self.view.bounds.size.width / 2;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i % 2) * width, 100 + (i / 2) * width, width, width)];
        
        imageView.image = [UIImage ad_imageNamed:names[i]];

//        imageView.image = [UIImage imageNamed:names[i]];
        
//        NSArray *arr = [names[i] componentsSeparatedByString:@"."];
//        NSString *path = [[NSBundle mainBundle] pathForResource:arr.firstObject ofType:arr.lastObject];
//        imageView.image = [UIImage imageWithContentsOfFile:path];

        [self.view addSubview:imageView];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"------ %@", [[ADImageCacheManager manager] allCachedImages]);
}

@end
