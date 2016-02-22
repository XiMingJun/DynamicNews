//
//  ViewController.m
//  DynamicNews
//
//  Created by wangjian on 15/8/6.
//  Copyright (c) 2015年 qhfax. All rights reserved.
//

#import "ViewController.h"
#import "DynamicNewsView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view, typically from a nib.
    DynamicNewsView *view = [[DynamicNewsView alloc] initWithFrame:CGRectMake(20, 50,[[UIScreen mainScreen] bounds].size.width - 20*2, 25)];
    view.dynamicBlock = ^(long index) {
    
        NSLog(@"---》》%ld",index);
        
    };
    [self.view addSubview:view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
