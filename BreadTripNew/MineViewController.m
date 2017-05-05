//
//  MineViewController.m
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/2.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "TableHeaderView.h"
#import "MineModel.h"
#import "InfoViewController.h"
#define kHEIGHT [UIScreen mainScreen].bounds.size.width
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIView *view;
    MineModel *mm;
    TableHeaderView *tabelHeaderV;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MineViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.alpha = 0;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:255/250.0 green:250/250.0 blue:240/250.0 alpha:1];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"MineTableViewCell"];
    
    // 将表格的边距离 向下高度                         上  下  左  右
    self.tableView.contentInset = UIEdgeInsetsMake(kHEIGHT, 0, 0, 0);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kHEIGHT, [UIScreen mainScreen].bounds.size.width, kHEIGHT)];
    imageView.image = [UIImage imageNamed:@"1.png"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.tag = 1001;
    imageView.userInteractionEnabled = YES;
    [self.tableView addSubview:imageView];
    
    
    mm = [[MineModel alloc] init];
    mm.flower = [NSString stringWithFormat:@"%@\n%@",@"0",@"粉丝"];
    mm.guanzhu = [NSString stringWithFormat:@"%@\n%@",@"1",@"关注"];
    mm.icon = @"2.png";
    mm.name = @"新用户";
    
    tabelHeaderV = [[TableHeaderView alloc] initWithFrame:CGRectMake(0, -kHEIGHT, [UIScreen mainScreen].bounds.size.width, kHEIGHT)];
    tabelHeaderV.model = mm;
    [self.tableView addSubview:tabelHeaderV];
   
    
    // 添加手势进入个人信息
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [tabelHeaderV.namelab addGestureRecognizer:tapGes];
    
    // 添加手势进入更换图像
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick2)];
    [tabelHeaderV.iconImage addGestureRecognizer:tapGest];
    

    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    view.backgroundColor = [UIColor colorWithRed:0/250.0 green:139/250.0 blue:139/250.0 alpha:0];
    [self.view addSubview:view];
    
    // 创建返回按钮 和列表箭头
    UIButton *backBtn = [UIButton buttonWithType:0];
    [backBtn setImage:[UIImage imageNamed:@"返回箭头"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(10, 25, 35, 35);
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
    
    UIButton *listBtn = [UIButton buttonWithType:0];
    [listBtn setImage:[UIImage imageNamed:@"列表"] forState:UIControlStateNormal];
    listBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 45, 25, 35, 35);
    [view addSubview:listBtn];
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell" forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor colorWithWhite:120/250.0 alpha:1];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",@"游记&故事集"];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= -kHEIGHT ) {
        CGRect rect = [self.tableView viewWithTag:1001].frame;
        rect.origin.y = scrollView.contentOffset.y;
        rect.size.height = -scrollView.contentOffset.y;
        [self.tableView viewWithTag:1001].frame = rect;

        view.backgroundColor = [UIColor colorWithRed:0/250.0 green:139/250.0 blue:139/250.0 alpha:0];
    }else{
        // 视图的alpha值 因为偏移量是负的 所以这里需要在添加负号 转化为正的
        CGFloat colorAlpha = -scrollView.contentOffset.y / 1000;
        view.backgroundColor = [UIColor colorWithRed:0/250.0 green:139/250.0 blue:139/250.0 alpha:colorAlpha];
    }
}


- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.alpha = 1;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


// 点击头像换图
- (void)tapClick {
    // 跳转
    InfoViewController *ifo = [[InfoViewController alloc] init];
    ifo.iconss = mm.icon;
    [self.navigationController pushViewController:ifo animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)tapClick2 {
    // 弹出提示框
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"更新头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从个人相册上传", nil];
    [sheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            // 拍照
            [self readImageFromCamera];
            break;
        case 1:
            // 从相册中读取
            [self readImageFromAlbum];
            break;
        default:
            break;
    }
}
- (void)readImageFromAlbum {
    //创建对象
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //（选择类型）表示仅仅从相册中选取照片
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    //指定代理
    imagePicker.delegate = self;
    //设置在相册选完照片后，是否跳到编辑模式进行图片剪裁。(允许用户编辑)
    imagePicker.allowsEditing = YES;
    //显示相册
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}
- (void)readImageFromCamera {
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES; //允许用户编辑
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        //弹出窗口响应点击事件
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"
                                                        message:@"未检测到摄像头" delegate:nil cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    tabelHeaderV.iconImage.image = image;
    
    //结束操作
    [self dismissViewControllerAnimated:YES completion:nil];
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
