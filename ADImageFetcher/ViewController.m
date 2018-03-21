//
//  ViewController.m
//  ADImageFetcher
//
//  Created by Andy on 21/03/2018.
//  Copyright © 2018 Andy. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ADCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *names = @[@"reba"];
    for (int i = 0; i < names.count; i++) {
        CGFloat width = self.view.bounds.size.width / 2;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i % 2) * width, 100 + (i / 2) * width, width, width)];
        imageView.image = [UIImage ad_imageNamed:names[i]];
        [self.view addSubview:imageView];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
