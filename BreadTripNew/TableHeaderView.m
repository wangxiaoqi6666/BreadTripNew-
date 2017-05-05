//
//  TableHeaderView.m
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/3.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "TableHeaderView.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@interface TableHeaderView()
@property (nonatomic, strong) UILabel *flowlab,*guanzhulab,*dengji;
@property (nonatomic, strong) UIButton *messBtn;

@end
@implementation TableHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _flowlab = [[UILabel alloc] init];
        _flowlab.numberOfLines = 2;
        _flowlab.textColor = [UIColor whiteColor];
        _flowlab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.flowlab];
        
        _guanzhulab = [[UILabel alloc] init];
        _guanzhulab.numberOfLines = 2;
        _guanzhulab.textColor = [UIColor whiteColor];
        _guanzhulab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.guanzhulab];
        
        _namelab = [[UILabel alloc] init];
        _namelab.textColor = [UIColor whiteColor];
        _namelab.font = [UIFont systemFontOfSize:20];
        _namelab.textAlignment = NSTextAlignmentCenter;
        _namelab.userInteractionEnabled = YES;
        [self addSubview:self.namelab];
        
        _dengji = [[UILabel alloc] init];
        _dengji.backgroundColor = [UIColor colorWithWhite:200/250.0 alpha:0.9];
        _dengji.text = @"Lv.1";
        _dengji.textColor = [UIColor whiteColor];
        [self addSubview:self.dengji];
        
        _iconImage = [[UIImageView alloc] init];
        _iconImage.backgroundColor = [UIColor whiteColor];
        _iconImage.layer.cornerRadius = 40;
        _iconImage.layer.masksToBounds = YES;
    
        _iconImage.userInteractionEnabled = YES;
        [self addSubview:self.iconImage];
        
        _messBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messBtn setTitle:@"消息" forState:UIControlStateNormal];
        [_messBtn setBackgroundColor:[UIColor whiteColor]];
        [_messBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _messBtn.layer.cornerRadius = 20;
        [self addSubview:self.messBtn];
    }
    return self;
}
- (void)setModel:(MineModel *)model {
    _model = model;
//    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    _iconImage.image = [UIImage imageNamed:model.icon];
    _flowlab.text = model.flower;
    _guanzhulab.text = model.guanzhu;
    _namelab.text = model.name;

    NSMutableAttributedString *stt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",model.flower]];
    [stt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:22] range:NSMakeRange(0, 1)];
    _flowlab.attributedText = stt;
    
    NSMutableAttributedString *stt2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",model.guanzhu]];
    [stt2 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:22] range:NSMakeRange(0, 1)];
    _guanzhulab.attributedText = stt2;
    
    __weak typeof(self)weakSelf  = self;
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(weakSelf.mas_top).offset(120);
    }];

    [_flowlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_iconImage.mas_centerY);
        make.right.mas_equalTo(_iconImage.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    
    [_guanzhulab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_iconImage.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.left.mas_equalTo(_iconImage.mas_right).offset(10);
    }];
    
    [_namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(_iconImage.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width, 50));
    }];
    
    [_messBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-60);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(40);
        make.width.equalTo(self.messBtn.mas_height).multipliedBy(2.0f);
    }];
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
