//
//  ViewController.m
//  GemNetworkRequest
//
//  Created by GemShi on 2017/2/1.
//  Copyright © 2017年 GemShi. All rights reserved.
//

#import "ViewController.h"
#import "GemNetworkManager.h"

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
//    [manager requestBySessionWithURL:@"http://d.yixincao.com/interface/getdata.php" Interface:@"" KeyArray:@[@"act",@"type",@"page"] ValueArray:@[@"list",@"nuanwen",@"3"] NetWorkBlock:^(id response) {
//
//        NSLog(@"%@",response);
//
//    } GetOrPost:YES];
    
//    GemNetworkManager *manager = [[GemNetworkManager alloc]init];
//    [manager requestByConnectionWithURL:@"http://d.yixincao.com/interface/getdata.php" Interface:@"" KeyArray:@[@"act",@"type",@"page"] ValueArray:@[@"list",@"nuanwen",@"3"] NetWorkBlock:^(id response) {
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
