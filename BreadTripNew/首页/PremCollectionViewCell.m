//
//  PremCollectionViewCell.m
//  BreadTripWXQ
//
//  Created by 王小琪 on 16/12/26.
//  Copyright © 2016年 王小琪. All rights reserved.
//

#import "PremCollectionViewCell.h"
#import "UIViewExt.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
@interface PremCollectionViewCell()

@property (strong, nonatomic) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titlelabel,*sublabel,*localabel,*namelabel;
@property (nonatomic, strong) UIView *backV;

@property (nonatomic, strong) UIImageView *picimageV;

@end
@implementation PremCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titlelabel];
        [self.contentView addSubview:self.sublabel];
        [self.contentView addSubview:self.localabel];
        [self.contentView addSubview:self.picimageV];
        [self.contentView addSubview:self.button];
        [self.contentView addSubview:self.namelabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
}




-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.cornerRadius = 5;
        _imageView.layer.masksToBounds = YES;
        [self.imageView addSubview:self.backV];
    }return _imageView;
}
// 遮罩层
- (UIView *)backV {
    if (!_backV) {
        _backV = [[UIView alloc] init];
        _backV.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:0.05];
    }return _backV;
}
-(UILabel *)titlelabel
{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.textColor=[UIColor whiteColor];
        _titlelabel.font=[UIFont boldSystemFontOfSize:20];
        _titlelabel.numberOfLines = 0;
        [_titlelabel sizeToFit];
        
    }return _titlelabel;
}
-(UILabel *)sublabel
{
    if (!_sublabel) {
        _sublabel = [[UILabel alloc] init];
        _sublabel.textColor = [UIColor whiteColor];
        _sublabel.font = [UIFont boldSystemFontOfSize:10];
        
           }
    return _sublabel;
}
-(UILabel *)localabel {
    if (!_localabel) {
        _localabel = [[UILabel alloc] init];
        _localabel.textColor = [UIColor whiteColor];
        _localabel.font = [UIFont systemFontOfSize:9];
        
    }
    return _localabel;
}
-(UIImageView *)picimageV
{
    if (!_picimageV) {
        _picimageV = [[UIImageView alloc] init];
        _picimageV.image = [UIImage imageNamed:@"newbar"];
        
    }return _picimageV;
}
- (UIImageView *)button {
    if (!_button) {
        _button = [[UIImageView alloc] init];
        _button.layer.cornerRadius = 15;
        _button.layer.masksToBounds = YES;
        _button.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes)];
        [self.button addGestureRecognizer:tap];
    }
    return _button;
}
- (UILabel *)namelabel {
    if (!_namelabel) {
        _namelabel = [[UILabel alloc] init];
        _namelabel.textColor = [UIColor whiteColor];
        _namelabel.font = [UIFont systemFontOfSize:11];
    
    }
    return _namelabel;
}


- (void)setModel:(ColleModel_elements_data *)model {
    _model = model;
    NSLog(@"%@",_model);
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_model.cover_image]];
    _titlelabel.text = _model.name;
    _sublabel.text = [NSString stringWithFormat:@"%@ %ld天 %ld浏览",_model.first_day,_model.day_count,_model.view_count];
    _localabel.text = model.popular_place_str;
    NSMutableAttributedString *stt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"by %@",_model.user.name]];
    [stt addAttribute:NSFontAttributeName value:[UIFont italicSystemFontOfSize:10] range:NSMakeRange(0, 2)];
    _namelabel.attributedText = stt;
    [_button sd_setImageWithURL:[NSURL URLWithString:_model.user.avatar_m]];
    _button.tag = _model.user.userid;
    
    __weak typeof(self) weakSelf = self;
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [_backV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.imageView).offset(0);
    }];
    
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(12);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
    }];
    
    [_picimageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titlelabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(weakSelf.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(5, 25));
    }];
    
    [_sublabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titlelabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(_picimageV.mas_right).offset(5);
        
        make.size.mas_equalTo(CGSizeMake(200, 10));
    }];
    //
    [_localabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sublabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(_picimageV.mas_right).offset(5);
        
        make.size.mas_equalTo(CGSizeMake(100, 10));
    }];
    
    //
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_button.mas_right).offset(5);
        make.centerY.mas_equalTo(_button.mas_centerY);
        make.height.mas_equalTo(10);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-10);
    }];
//    __weak typeof(self) weakSelf = self;
//    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
//    [_backV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
//    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(weakSelf.mas_left).offset(15);
//        make.top.mas_equalTo(weakSelf.mas_top).offset(12);
//        make.right.mas_equalTo(weakSelf.mas_right).offset(-15);
//    }];
//    [_picimageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_titlelabel.mas_left);
//        make.top.mas_equalTo(_titlelabel.mas_bottom).offset(5);
//        make.size.mas_equalTo(CGSizeMake(5, 25));
//    }];
//    [_sublabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_picimageV.mas_right).offset(5);
//        make.top.mas_equalTo(_picimageV.mas_top);
//        make.size.mas_equalTo(CGSizeMake(200, 10));
//    }];
//    [_localabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_sublabel.mas_left);
//        make.top.mas_equalTo(_sublabel.mas_bottom).offset(5);
//        make.size.mas_equalTo(CGSizeMake(100, 10));
//    }];
//    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_picimageV.mas_left);
//        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-15);
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//    }];
//    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_button.mas_right).offset(5);
//        make.centerY.mas_equalTo(_button.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(100, 10));
//    }];
}

-(void)tapGes {
    if (self.tapActionBlock) {
        self.tapActionBlock(_button.tag);
    }
}


@end
