//
//  ViewController.m
//  GemNetworkRequest
//
//  Created by GemShi on 2017/2/1.
//  Copyright © 2017年 GemShi. All rights reserved.
//

#import "ViewController.h"
#import "GemNetworkManager.h"

#define URL1 @"http://d.yixincao.com/interface/getdata.php"
#define URL2 @"http://d.yixincao.com/interface/getdata.php"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"Request" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(requestClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)requestClick
{
//    GemNetworkManager *manager = [[GemNetworkManager alloc]init];
//    [manager requestBySessionWithURL:URL1 Interface:@"" KeyArray:@[@"act",@"type",@"page"] ValueArray:@[@"list",@"nuanwen",@"3"] NetWorkBlock:^(id response) {
//
//        NSLog(@"%@",response);
//
//    } GetOrPost:YES];
    
//    GemNetworkManager *manager = [[GemNetworkManager alloc]init];
//    [manager requestByConnectionWithURL:URL2 Interface:@"" KeyArray:@[@"act",@"type",@"page"] ValueArray:@[@"list",@"nuanwen",@"3"] NetWorkBlock:^(id response) {
//
//        NSLog(@"%@",response);
//
//    } GetOrPost:YES];
    
    BOOL isExist = [GemNetworkManager isExistenceNetwork];
    NSLog(@"%@",[NSNumber numberWithBool:isExist]);
    
    NSString *statesStr = [GemNetworkManager networkingStatesFromStatebar];
    NSLog(@"%@",statesStr);
    
    NSInteger statesNum = [GemNetworkManager networkingStatesNumber];
    NSLog(@"%ld",statesNum);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
