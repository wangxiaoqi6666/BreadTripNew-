//
//  TouchViewController.m
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/12.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "TouchViewController.h"
#import <UIImageView+WebCache.h>
#import "AppDelegate.h"
@interface TouchViewController ()
@property (nonatomic, strong) UIAlertController *alertC;
@end
@implementation TouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *image = [[UIImageView alloc] init];
    [image sd_setImageWithURL:[NSURL URLWithString:self.name]];
    image.backgroundColor = [UIColor yellowColor];
    
    image.frame = CGRectMake(20, 0, self.view.frame.size.width - 40, self.view.frame.size.width - 40);
    
    image.center = CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height - 64) / 2);
    
    [self.view addSubview:image];
}


- (NSArray *)previewActionItems {
    
      UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"喜欢" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        // 点击此选项触发
        
        self.alertC = [UIAlertController alertControllerWithTitle:@"喜欢了该游记" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [self.alertC addAction:alert];
        
        // 因为预览视图与根视图不在一个视图层级上，所以需要通过根视图去推出这个
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.alertC animated:YES completion:^{
            
        }];
        
    }];
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"分享..." style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        // 因为预览视图与根视图不在一个视图层级上，所以需要通过根视图去推出这个
        NSArray *array = @[@"hello 3D Touch"];
        UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:array applicationActivities:nil];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:^{
            
        }];
        
    }];
    // 可以添加多个选项
    NSArray *arr = @[action1,action2];
    
    return arr;
    
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
