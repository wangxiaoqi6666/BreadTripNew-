//
//  HeaderView.m
//  DetailTableDemo
//
//  Created by 王小琪 on 17/1/8.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "HeaderView.h"
#import <SDAutoLayout.h>
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "NSString+Helper.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface HeaderView()
@property (nonatomic, strong) UILabel *namelab,*linelab,*datelab,*meterlab;
@property (nonatomic, strong) UILabel *likelab;
@property (nonatomic, strong) UIButton *button;
@end

@implementation HeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 200)];
        self.imageV.userInteractionEnabled = YES;
        [self addSubview:self.imageV];
        
        self.iconV = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW-80)/2, 160, 80, 80)];
        _iconV.layer.cornerRadius = 40;
        _iconV.layer.masksToBounds = YES;
        _iconV.layer.borderColor = [UIColor colorWithRed:255/250.0 green:248/250.0 blue:230/250.0 alpha:1].CGColor;
        _iconV.layer.borderWidth = 3;
        [self addSubview:self.iconV];
        
        self.userlab = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, kScreenW, 20)];
        _userlab.textColor = [UIColor lightGrayColor];
        _userlab.font = [UIFont systemFontOfSize:12];
        _userlab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.userlab];
        
        _namelab = [[UILabel alloc] init];
        _namelab.numberOfLines = 0;
        _namelab.font = [UIFont systemFontOfSize:20];
        _namelab.textColor = [UIColor colorWithWhite:0.2 alpha:1];
        _namelab.shadowColor = [UIColor lightGrayColor];
        _namelab.shadowOffset = CGSizeMake(0,2);
        _namelab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.namelab];
        
        _linelab = [[UILabel alloc] init];
        _linelab.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.linelab];
        
        _datelab = [[UILabel alloc] init];
        _datelab.numberOfLines = 2;
        _datelab.textAlignment = NSTextAlignmentCenter;
        _datelab.textColor = [UIColor lightGrayColor];
        _datelab.font = [UIFont systemFontOfSize:14];
        [self addSubview:_datelab];
        
        _meterlab = [[UILabel alloc] init];
        _meterlab.numberOfLines = 2;
        _meterlab.textAlignment = NSTextAlignmentCenter;
        _meterlab.textColor = [UIColor lightGrayColor];
        _meterlab.font = [UIFont systemFontOfSize:14];
        [self addSubview:_meterlab];
        
        _likelab = [[UILabel alloc] init];
        _likelab.numberOfLines = 2;
        _likelab.textAlignment = NSTextAlignmentCenter;
        _likelab.font = [UIFont systemFontOfSize:14];
        _likelab.textColor = [UIColor lightGrayColor];
        [self addSubview:_likelab];
        
        // 点击视频按钮
        _button = [[UIButton alloc] initWithFrame:CGRectMake((kScreenW - 65)/2, 80, 65, 30)];
        _button.backgroundColor = [UIColor blackColor];
        _button.alpha = 0.5;
        [_button setImage:[UIImage imageNamed:@"播放按钮"] forState:UIControlStateNormal];
        _button.layer.cornerRadius = 15;
        _button.layer.masksToBounds = YES;
        [self.imageV addSubview:self.button];
                
    }return self;
}


- (void)setDetailmodel:(DetailModel *)detailmodel {
    _detailmodel = detailmodel;
    
    [_imageV sd_setImageWithURL:[NSURL URLWithString:_detailmodel.trackpoints_thumbnail_image] placeholderImage:[UIImage imageNamed:@"beauti"]];
//    _userlab.text = [NSString stringWithFormat:@"by %@",@"Mona小思宇"];
    _namelab.text = detailmodel.name;
    
    
    // 设置同一label上的字体不同 颜色也不同
    NSMutableAttributedString *stt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"2015.12.21\n%@天",_detailmodel.day_count]];
    [stt addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13.0f],
                         NSForegroundColorAttributeName:[UIColor colorWithWhite:0.35 alpha:1]} range:NSMakeRange(0, 10)];
    _datelab.attributedText = stt;// 天数
    
    // 将里程数转化为整数
    float f = [_detailmodel.mileage floatValue];
    int a;
    a = (int)f;
    NSMutableAttributedString *stt1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"里程\n %dkm",a]];
    [stt1 addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13.0f],
                         NSForegroundColorAttributeName:[UIColor colorWithWhite:0.35 alpha:1]} range:NSMakeRange(0, 2)];
    _meterlab.attributedText = stt1;

    NSMutableAttributedString *stt2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"喜欢\n%@",@"129"]];
    [stt2 addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13.0f],
                         NSForegroundColorAttributeName:[UIColor colorWithWhite:0.35 alpha:1]} range:NSMakeRange(0, 2)];
    _likelab.attributedText = stt2;
    
    //文字
    CGFloat textY = 280;
    CGSize textsize = [self.namelab.text sizeWithFont:[UIFont systemFontOfSize:20] maxW:kScreenW/6 *4];
    CGFloat textX = kScreenW/6;
    self.namelab.frame = CGRectMake(textX,textY,kScreenW/3*2,textsize.height);
    
    CGFloat lineY = CGRectGetMaxY(self.namelab.frame) + 20;
    _linelab.frame = CGRectMake(kScreenW/6, lineY, _namelab.frame.size.width, 0.6);
    CGFloat dateY = CGRectGetMaxY(self.namelab.frame) + 20;
    _datelab.frame = CGRectMake(kScreenW/6, dateY, _namelab.frame.size.width / 3, 60);
    _meterlab.frame = CGRectMake(_datelab.frame.origin.x + _datelab.frame.size.width, dateY, _namelab.frame.size.width / 3, 60);
    _likelab.frame = CGRectMake(_meterlab.frame.origin.x + _meterlab.frame.size.width, dateY, _namelab.frame.size.width / 3, 60);
    
    _height = CGRectGetMaxY(self.datelab.frame) + 40;
    
//    _imageV.sd_layout.leftEqualToView(self).rightEqualToView(self).topEqualToView(self).heightIs(200);
//    _button.sd_layout.centerXIs(kScreenW/2).centerYIs(_imageV.centerY).widthIs(60).heightIs(30);
//    _iconV.sd_layout.topSpaceToView(_imageV,-40).centerXIs(kScreenW/2).heightIs(80).widthIs(80);
//    _userlab.sd_layout.topSpaceToView(_iconV,10).centerXIs(kScreenW/2).widthIs(200).heightIs(20);
//    _namelab.sd_layout.topSpaceToView(_userlab,10).centerXIs(kScreenW/2).widthIs(kScreenW-140).autoHeightRatio(0);
//    _linelab.sd_layout.topSpaceToView(_namelab,20).centerXIs(kScreenW/2).heightIs(0.6).widthIs(kScreenW-140);
//    _datelab.sd_layout.topSpaceToView(_linelab,10).widthIs(_linelab.width/3).heightIs(_linelab.width/3 - 20).leftEqualToView(_linelab);
//    _meterlab.sd_layout.topSpaceToView(_linelab,10).centerXIs(kScreenW/2).heightIs(_linelab.width/3 - 20).widthIs(_linelab.width/3);
//    _likelab.sd_layout.topSpaceToView(_linelab,10).rightEqualToView(_linelab).heightIs(_linelab.width/3 - 20).widthIs(_linelab.width/3);
//    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(200);
//    }];
//    [_iconV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_imageV.mas_bottom).offset(-40);
//        make.centerX.mas_equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(80, 80));
//    }];
//    [_userlab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_iconV.mas_bottom).offset(10);
//        make.centerX.mas_equalTo(_iconV.centerX);
//        make.size.mas_equalTo(CGSizeMake(200, 20));
//    }];
//    [_namelab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_userlab.mas_bottom).offset(10);
//        make.centerX.mas_equalTo(_iconV.centerX);
//        make.width.mas_equalTo(kScreenW-140);
//        
//    }];
//    [_linelab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_namelab.mas_bottom).offset(20);
//        make.centerX.equalTo(_iconV.mas_centerX);
//        make.size.mas_equalTo(CGSizeMake(kScreenW-140, 0.6));
//    }];
//    [_datelab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_linelab.mas_bottom).offset(10);
//        make.width.mas_equalTo(_linelab.mas_width).multipliedBy(0.33);
//        make.height.mas_equalTo(50);
//        make.left.mas_equalTo(_linelab.mas_left);
//    }];
//    [_meterlab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_linelab.mas_bottom).offset(10);
//        make.width.mas_equalTo((kScreenW-140)/3);
//        make.height.mas_equalTo(50);
//        make.centerX.mas_equalTo(_linelab.centerX);
//    }];
//    [_likelab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_linelab.mas_bottom).offset(10);
//        make.width.mas_equalTo((kScreenW-140)/3);
//        make.height.mas_equalTo(50);
//        make.right.mas_equalTo(_linelab.mas_right);
//    }];
    
//    [self mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(_likelab.mas_bottom).offset(10);
//    }];
    
//    self.height = CGRectGetMaxY(self.frame);
    NSLog(@"selfheight======%lf",self.height);
    
}



@end
