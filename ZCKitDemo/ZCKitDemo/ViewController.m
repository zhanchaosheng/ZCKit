//
//  ViewController.m
//  ZCKitDemo
//
//  Created by Cusen on 2017/4/8.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import "ViewController.h"
#import <ZCKit/ZCKit.h>
#import "ScannerViewController.h"

@interface ViewController ()

@property (nonatomic, strong) ZCSegmentedControl *sectionView;
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    self.navBarBgAlpha = 0.5;
    self.navBarTintColor = [UIColor orangeColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"扫描"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(rightBarButtionItemClicked:)];
    
    // 创建segmentedControl
    CGRect segmentedCtrlRect = CGRectMake(0, 64, self.view.bounds.size.width, 50);
    NSArray *titles = [NSArray arrayWithObjects:@"推荐",@"视频",@"热点",@"订阅", nil];
    ZCSegmentedControl *sectionView = [ZCSegmentedControl segmentWithFrame:segmentedCtrlRect
                                                                    titles:titles
                                                                    tClick:^(NSInteger index) {
                                                                        NSLog(@"SegmentedControl is clicked: %ld",(long)index);
                                                                    }];
    // 设置其他颜色
    [sectionView setNormalColor:[UIColor blackColor]
                    selectColor:[UIColor redColor]
                    sliderColor:[UIColor redColor]
                    edgingColor:[UIColor clearColor]
                    edgingWidth:0];
    self.sectionView = sectionView;
    [self.view addSubview:sectionView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBarButtionItemClicked:(id)sender {
    ScannerViewController *vc = [[ScannerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
