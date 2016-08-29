//
//  ViewController.m
//  PYMJRefresh
//
//  Created by Apple on 16/8/2.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加一个tableview
    self.tableView= [[UITableView alloc]initWithFrame:self.view.bounds];
    
    self.tableView.delegate=self;
    
    self.tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
    
    
    //创建下拉刷新
    MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self performSelector:@selector(headRefresh)withObject:nil afterDelay:1.0f];//延迟时间
        
    }];
    
    //设置自定义文字，因为默认是英文的
    [header setTitle:@"下拉刷新"forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开加载更多"forState:MJRefreshStatePulling];
    
    [header setTitle:@"正在刷新中"forState:MJRefreshStateRefreshing];
    
    
    self.tableView.mj_header= header;
    
    //创建上拉刷新
    MJRefreshBackNormalFooter * foot =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self performSelector:@selector(footRefresh)withObject:nil afterDelay:1.0f];
        
    }];
    self.tableView.mj_footer= foot;
    
    [foot setTitle:@"上拉刷新"forState:MJRefreshStateIdle];
    
    [foot setTitle:@"松开加载更多"forState:MJRefreshStatePulling];
    
    [foot setTitle:@"正在刷新中"forState:MJRefreshStateRefreshing];
    
}
- (void)headRefresh {
    NSLog(@"下拉,加载数据");
    [self.tableView.mj_header endRefreshing];//结束刷新
}
- (void)footRefresh {
    NSLog(@"上拉，加载数据");
    [self.tableView.mj_footer endRefreshing];
}



# pragma mark - tabelView代理方法.
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return 10;
    
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    NSString* cellReuseIdentifier =@"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellReuseIdentifier];
    
    if(!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        
    }
    
    cell.textLabel.text=@"11";
    
    return cell;
    
}


@end