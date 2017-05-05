//
//  InfoViewController.m
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/4.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "InfoViewController.h"
#import <UIImageView+WebCache.h>
#import "MineModel.h"
@interface InfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSDictionary *dic,*dic2;
    UIImageView *imageV;
}

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    self.navigationItem.hidesBackButton = YES;
    UIImage *image = [UIImage imageNamed:@"返回箭头"];
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(backBtn)];
    
    
    tableV = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableV];
    dic = @{@"0":@[@"头像",@"用户名"],@"1":@[@"手机号码",@"邮箱"],@"2":@[@"地区",@"性别",@"生日",@"个人介绍"]};
    dic2 = @{@"0":@[@"",@"新用户"],@"1":@[@"未设置",@"未设置"],@"2":@[@"请选择",@"女",@"请选择",@"未设置"]};
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0){
            return 100;
        }else {
            return 50;
        }
    }else {
        return 50;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dic.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [[dic objectForKey:[dic allKeys][section]] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuse = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse];
    }
    
    cell.textLabel.text = [dic objectForKey:[dic allKeys][indexPath.section]][indexPath.row];
    cell.detailTextLabel.text = [dic2 objectForKey:[dic2 allKeys][indexPath.section]][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            imageV = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 110, 20, 70, 70)];
            imageV.layer.cornerRadius = 35;
            imageV.layer.masksToBounds = YES;
            imageV.image = [UIImage imageNamed:self.iconss];
            [cell.contentView addSubview:imageV];
        }
    }
    
    return cell;
}
- (void)backBtn {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
