//
//  PremViewController.m
//  BreadTripWXQ
//
//  Created by 王小琪 on 16/12/25.
//  Copyright © 2016年 王小琪. All rights reserved.
//


#import "PremViewController.h"
#import "UIViewExt.h"
#import "MineViewController.h"
#import <SDCycleScrollView.h>
#import "PremCollectionViewCell.h"
#import "NavTableViewCell.h"
#import "DetailViewController.h"
#import "MyReusableView.h"
#import "ColleModel.h"
#import "PremModel.h"
#import "SeletData.h"
#import "BWGetRequest.h"
#import "ColleModel_elements_type1.h"
#import "ScrollViewController.h"
#import "MapViewController.h"
#import "TouchViewController.h"
#import <MJRefresh.h>

#define kWidth [UIScreen mainScreen].bounds.size.width
#define URL @"http://api.breadtrip.com/v2/index/?"

@interface PremViewController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIViewControllerPreviewingDelegate>
{
    UITextField *inputField;
    UIButton *_cancelBtn,*_fujinBtn;
    SDCycleScrollView *scrollView;
    UIButton *addBtn;
    UICollectionView *collectionV;
    UIView *view;
    UIButton *first,*second;
    UITableView *_searchTableView;
    ColleModel *_model;
    NSMutableArray *collarrM;// 存放接受model解析的数据
    NSArray *scrollarrM;// 存放滚动视图数据
    NSMutableArray *searcharr;//搜索保存的数组
    PremModel *prem;
    NSMutableArray *magarr;
    NSMutableArray *tmpArray;
}
@property (nonatomic, strong) NSMutableArray *tagsFrames,*searchResluts;
@property (nonatomic, strong) NSArray *tagsArray;
@property (nonatomic, assign) CGFloat ang;

@end

@implementation PremViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    collarrM = [NSMutableArray array];
    scrollarrM = [NSMutableArray array];
    searcharr = [NSMutableArray array];
    
    // 3Dtouch
    [self showTouch];
    
    // 设置各种导航栏样式
    self.navigationController.navigationBar.translucent = NO;// 非半透明
    
    // 修改导航栏标题的颜色和字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont boldSystemFontOfSize:20]};
    
    [self createNavItems];
    [self setInACollectionView];
    [self createAddBtn];
    [self configNetwork];// 解析网格单元格数据
    [self selectTableNetwork];// 请求搜索标题的数据
    
    // MJ动图刷新
    tmpArray = [NSMutableArray array];
    for (NSInteger i = 1; i<=32; i++) {
        [tmpArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"hand%ld.tiff",i]]];
    }
    MJRefreshGifHeader *headermag = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [headermag setImages:tmpArray forState:MJRefreshStateIdle];
    [headermag setImages:tmpArray forState:MJRefreshStatePulling];
    headermag.lastUpdatedTimeLabel.hidden = YES;
    headermag.stateLabel.hidden = YES;
    headermag.automaticallyChangeAlpha = YES;
    [headermag setImages:tmpArray forState:MJRefreshStateRefreshing];
    collectionV.mj_header = headermag;
    
    // 搜索按钮的数组
    _tagsFrames = [NSMutableArray array];
}
// 下拉刷新
- (void)loadNewData {
    [collectionV reloadData];
    [collectionV.mj_header endRefreshing];
}
// 请求搜索标题数据
- (void)selectTableNetwork {
    [SeletData GET:URL Parameter:nil Success:^(id success) {
        prem = (PremModel *)success;
        NSMutableArray *arrwai = [NSMutableArray array];
        NSMutableArray *arrnei = [NSMutableArray array];
        for (PremModel_search_data *sear in prem.search_data) {
            if ([sear.title isEqualToString:@"国外热门目的地"]) {
                for (PremModel_search_data_elements *ele in sear.elements) {
                    [arrwai addObject:ele.name];
                }
            }
            if ([sear.title isEqualToString:@"国内热门目的地"]) {
                for (PremModel_search_data_elements *ele in sear.elements) {
                    [arrnei addObject:ele.name];
                }
            }
        }
        _tagsArray = [NSArray arrayWithObjects:arrwai,arrnei, nil];
        [_tagsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TagsFrame *frame = [[TagsFrame alloc] init];
            frame.tagsArray = obj;
            
            [_tagsFrames addObject:frame];
        }];

    } Failure:^(id failure) {
        
    }];
}


// 解析网格单元格数据
- (void)configNetwork
{
    [BWGetRequest GetRequestQBWithURL:URL Params:nil success:^(id success) {
        _model = success[0];
        for (NSInteger i=0; i<_model.data.elements.count; i++) {
            if (i > 6) {
                [collarrM addObject:_model.data.elements[i]];
            }
        }
        scrollarrM = success[1];
        [collectionV reloadData];
    } failure:^(id failure) {
        
    }];
}

// 创建导航栏
- (void)createNavItems {
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    imageV.image = [UIImage imageNamed:@"navbar"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageV];
    // 搜索框
    inputField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, self.view.frame.size.width - 100, 35)];
    UIImage *image = [UIImage imageNamed:@"bar副本"];
    [image stretchableImageWithLeftCapWidth:5.0 topCapHeight:5.0];
    inputField.background = image;
    inputField.placeholder = @" 搜索国家、城市、景区、游记名";
    // 改变placeholder的文字样式 用setvalue forkeypath的方法
    [inputField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [inputField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    inputField.textColor = [UIColor whiteColor];
    inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
    inputField.keyboardType = UIKeyboardTypeDefault;
    inputField.textAlignment = NSTextAlignmentCenter;
    inputField.returnKeyType = UIReturnKeySearch;
    [inputField addTarget:self action:@selector(editing:) forControlEvents:UIControlEventAllEditingEvents];
    
    self.navigationItem.titleView = inputField;
    
    UIView *rightView = [[UIView alloc]initWithFrame: CGRectMake(20, 5, 35, 35)];
    rightView.backgroundColor = [UIColor clearColor];

    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.backgroundColor = [UIColor clearColor];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cancelBtn.hidden = YES;
    _cancelBtn.frame = CGRectMake(0, 5, 50, 30);

    _fujinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _fujinBtn.backgroundColor = [UIColor clearColor];
    [_fujinBtn setBackgroundImage:[UIImage imageNamed:@"wode-3"] forState:UIControlStateNormal];
    [_fujinBtn addTarget:self action:@selector(fujinAction) forControlEvents:UIControlEventTouchUpInside];
    _fujinBtn.hidden = NO;
    _fujinBtn.frame = CGRectMake(10, 5, 26, 26);
    [rightView addSubview:_cancelBtn];
    [rightView addSubview:_fujinBtn];
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = right2;
    
}
- (void)fujinAction
{
    NSLog(@"用户我的");
    MineViewController *fujinVc = [[MineViewController alloc]init];
    [self.navigationController pushViewController:fujinVc animated:YES];
}
// 搜索
- (void)editing:(UITextField *)inputff {
    if (_searchTableView == nil) {
        [self  ceateTableView];
    }
    _fujinBtn.hidden = YES;
    _cancelBtn.hidden = NO;
    _searchTableView.hidden = NO;
}


//收起搜索表的动画
- (void)cancelAction:(UIButton *)btn
{
    [inputField resignFirstResponder];
    
    _cancelBtn.hidden = YES;
    _fujinBtn.hidden = NO;
    
    [UIView animateWithDuration:0.4
                     animations:^{
                         _searchTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, 0);
                     } completion:^(BOOL finished) {
                         _searchTableView = nil;
                         [_searchTableView removeFromSuperview];
                         [_fujinBtn addTarget:self action:@selector(fujinAction) forControlEvents:UIControlEventTouchUpInside];
                     }];
    
}
// 下拉显示搜索表的表格
- (void)ceateTableView {
    _searchTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _searchTableView.backgroundColor = [UIColor colorWithRed:255/250.0 green:250/250.0 blue:240/250.0 alpha:1];
    _searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    _searchTableView.hidden = YES;
    [self.view addSubview:_searchTableView];
    
}
// 搜索表格方法
#pragma  mark -- UITableViewDataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _tagsFrames.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    NSMutableArray *arrH = [NSMutableArray arrayWithObjects:@"国外热门目的地",@"国内热门目的地", nil];
    label.text = arrH[section];
    return label;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NavTableViewCell *cell = [NavTableViewCell cellWithTableView:tableView];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tagsFrame = _tagsFrames[indexPath.section];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_tagsFrames[indexPath.section] tagsHeight];
}
// 网格视图
- (void)setInACollectionView {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(kWidth-20, kWidth/2);
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flow.headerReferenceSize = CGSizeMake(kWidth-20, 230);
    
    collectionV = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flow];
    collectionV.backgroundColor = [UIColor clearColor];
    collectionV.delegate=self;
    collectionV.dataSource=self;
   
    // 注册网格单元格
    [collectionV registerClass:[PremCollectionViewCell class] forCellWithReuseIdentifier:@"PremCollectionViewCell"];
    [collectionV registerClass:[MyReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:collectionV];
}

#pragma mark -- UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return collarrM.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PremCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"PremCollectionViewCell" forIndexPath:indexPath];
    
    ColleModel_elements *elem = collarrM[indexPath.row];
    cell.model = elem.data[0];
    cell.tapActionBlock = ^(NSInteger user_id){
        NSLog(@"%ld",user_id);
    };
    [self registerForPreviewingWithDelegate:(id)self sourceView:cell];
    return cell;
}
//循环滚动 网格页眉
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        MyReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (ColleModel_elements_type1 *type in scrollarrM) {
            [arr addObject:type.image_url];
        }
        
        header.scrollView.imageURLStringsGroup = arr;
        header.scrollView.delegate=self;
        return header;

    }
    return nil;
}
// 滚动视图 代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSMutableArray *arr = [NSMutableArray array];
    for (ColleModel_elements_type1 *type in scrollarrM) {
        [arr addObject:type.html_url];
    }
    
    // 存放下一界面导航标题
    NSArray *array = @[@"“滑雪季”面包旅行邀你嗨翻滑雪天堂北大壶",@"我的邻居是故宫，揭秘京城民宿界的网红",@"墨西哥城 给你的寒冬来点颜色",@"皇家加勒比赞礼号游轮",@"你所不知道的赫尔辛基"];
    
    ScrollViewController *scrll = [[ScrollViewController alloc] init];
    scrll.html_URL = arr[index];
    scrll.titleStr = array[index];
    [self.navigationController pushViewController:scrll animated:NO];
}


// 创建底部圆形加号按钮
- (void)createAddBtn {
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.0f;
    [self.view addSubview:view];
    addBtn = [[UIButton alloc] init];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"search_bac副本"] forState:UIControlStateNormal];
    [self performSelector:@selector(btnSetImage:) withObject:@"0" afterDelay:0.0f];
    [self performSelector:@selector(btnSetImage:) withObject:@"1" afterDelay:1.0f];
    [self performSelector:@selector(btnSetImage:) withObject:@"2" afterDelay:2.0f];
    
    addBtn.frame = CGRectMake((self.view.frame.size.width-70)/2, self.view.bottom-164, 70, 70);
    [self.view addSubview:addBtn];
    
    // 添加按钮点击弹出动画view
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)btnSetImage:(NSString *)num {
    if ([num isEqualToString:@"0"]) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.6];
        [addBtn setImage:[UIImage imageNamed:@"笔记"] forState:UIControlStateNormal];
        [UIView commitAnimations];
    }else if([num isEqualToString:@"1"]) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.6];
        [addBtn setImage:[UIImage imageNamed:@"相机"] forState:UIControlStateNormal];
        [UIView commitAnimations];
    }else if([num isEqualToString:@"2"]){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.6];
        [addBtn setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
        [UIView commitAnimations];
    }
    
}
//按钮点击事件的实现

- (void)addBtnClick {
        if (view.alpha == 0.0f) {
        view.alpha = 0.5f;
        first = [[UIButton alloc] init];
        second = [[UIButton alloc] init];

        [first setImage:[UIImage imageNamed:@"first"] forState:UIControlStateNormal];
        first.frame = CGRectMake((self.view.frame.size.width - 120)/2, addBtn.frame.origin.y - 135, 120, 120);
        [second setImage:[UIImage imageNamed:@"second"] forState:UIControlStateNormal];
        second.frame = CGRectMake((self.view.frame.size.width - 120)/2, first.frame.origin.y - 135, 120, 120);
        [self rotate];
        [UIView animateWithDuration:0.5 animations:^{
            addBtn.transform = CGAffineTransformMakeRotation( 3 * M_PI / 4);
            [self.view addSubview:first];
            [self.view addSubview:second];

            
        }completion:^(BOOL finished) {
            [first.layer removeAnimationForKey:@"group"];
            [second.layer removeAnimationForKey:@"group"];
        }];
        
    }else {
        [self backAnimation];
        [UIView animateWithDuration:0.5 animations:^{
            view.alpha = 0.0f;
            addBtn.transform = CGAffineTransformIdentity;
            [first removeFromSuperview];
            [second removeFromSuperview];
        }completion:^(BOOL finished) {
            [first.layer removeAnimationForKey:@"group1"];
        }];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (collectionV.contentOffset.y > 100) {
        
        [UIView animateWithDuration:0.3 animations:^{
        addBtn.transform = CGAffineTransformRotate(addBtn.transform, M_2_PI);
            addBtn.transform=CGAffineTransformMakeTranslation(0, 100);
        }];
    }else {
        [UIView animateWithDuration:0.3
                         animations:^{
            addBtn.transform = CGAffineTransformRotate(addBtn.transform, M_2_PI);
            addBtn.transform=CGAffineTransformMakeTranslation(0,0);
        }];
    }
}
- (void)rotate {
    //旋转
    CABasicAnimation *firstViewAnimation = [CABasicAnimation animation];
    firstViewAnimation.fromValue = @0;
    firstViewAnimation.toValue = @(-M_PI*2);
    firstViewAnimation.keyPath = @"transform.rotation.z";
    //缩放
    CABasicAnimation *secondAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    secondAnimation.fromValue = @0;
    secondAnimation.toValue = @1;
    //组动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.5;
    group.animations = @[firstViewAnimation, secondAnimation];
    [first.layer addAnimation:group forKey:@"group"];
    [second.layer addAnimation:group forKey:@"group"];
}
- (void)backAnimation
{
    //旋转
    CABasicAnimation *firstViewAnimation = [CABasicAnimation animation];
    firstViewAnimation.fromValue = @0;
    firstViewAnimation.toValue = @(-M_PI*2);
    firstViewAnimation.keyPath = @"transform.rotation.z";
    //组动画
    CAAnimationGroup *group1 = [CAAnimationGroup animation];
    group1.duration = 0.5;
    group1.animations = @[firstViewAnimation];
    [first.layer addAnimation:group1 forKey:@"group1"];
    [second.layer addAnimation:group1 forKey:@"group1"];
}
// 点击网格单元格 跳转到下一界面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detail = [[DetailViewController alloc] init];
    
    ColleModel_elements *elem = collarrM[indexPath.row];
    ColleModel_elements_data *dd = elem.data[0];
    detail.lastid = dd.id_id;
    NSLog(@"%@",detail.lastid);
    
    ColleModel_elements_data_user *user = dd.user;
    detail.username = user.name;
    detail.usericon = user.avatar_m;
    
    [self.navigationController pushViewController:detail animated:NO];
    // 设置下一页导航图片
    UIImage *navimage = [UIImage imageNamed:@"bgcolor"];
    [self.navigationController.navigationBar setBackgroundImage:navimage forBarMetrics:UIBarMetricsDefault];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    UIImage *navimage = [UIImage imageNamed:@"account_uploadavatar_btn"];
    [self.navigationController.navigationBar setBackgroundImage:navimage forBarMetrics:UIBarMetricsDefault];
}
- (void)showTouch {
    // 3Dtouch
    UIApplicationShortcutItem * item = [[UIApplicationShortcutItem alloc]initWithType:@"one" localizedTitle:@"我的" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome] userInfo:nil];
    UIApplicationShortcutItem * itemThird = [[UIApplicationShortcutItem alloc]initWithType:@"two" localizedTitle:@"分享" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare] userInfo:nil];
    
    [UIApplication sharedApplication].shortcutItems = @[item, itemThird];
}

// 3Dtouch
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    //通过预览上下文获取到当前按压的视图,判断indexPath值
    NSIndexPath *indexPath = [collectionV indexPathForCell:(UICollectionViewCell *)previewingContext.sourceView];
    
    TouchViewController *touch = [[TouchViewController alloc] init];
    magarr = [NSMutableArray array];
//    //通过上下文可以调整不被虚化的范围
//    previewingContext.sourceRect = CGRectMake(10, 10, 10, 10);
    
    if (indexPath == NULL) {
        
        return nil;
        
    } else {
        for (ColleModel_elements *ele in collarrM) {
             ColleModel_elements_data *magecover = ele.data[0];
            [magarr addObject:magecover.cover_image];
        }
        touch.name = [magarr objectAtIndex:indexPath.item];
        
        return touch;
        
    }
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController * _Nonnull)viewControllerToCommit

{
    viewControllerToCommit.view.backgroundColor = [UIColor whiteColor];
    
    [self showViewController:viewControllerToCommit sender:self];
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
