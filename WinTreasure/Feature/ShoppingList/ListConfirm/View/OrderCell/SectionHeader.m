//
//  SectionHeader.m
//  WinTreasure
//
//  Created by Apple on 16/6/20.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "SectionHeader.h"

@interface SectionHeader ()

@property (nonatomic, strong) YYLabel *titleLabel;

@property (nonatomic, strong) UIImageView *sortImgView;

@end

@implementation SectionHeader

+ (SectionHeader *)header {
    SectionHeader *header = [[SectionHeader alloc]initWithFrame:({
        CGRect rect = {0,0,kScreenWidth,[SectionHeader height]};
        rect;
    })];
    return header;
}

+ (CGFloat)height {
    return 44.0;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _sortImgView = [UIImageView new];
        _sortImgView.origin = CGPointMake(self.width-15-12.5, (self.height-8)/2.0);
        _sortImgView.size = CGSizeMake(12.5, 8);
        _sortImgView.image = IMAGE_NAMED(@"向上收起");
        [self addSubview:_sortImgView];
        
        _titleLabel = [YYLabel new];
        _titleLabel.origin = CGPointMake(15, 0);
        _titleLabel.size = CGSizeMake(_sortImgView.left-15*2, 18);
        _titleLabel.font = SYSTEM_FONT(16);
        _titleLabel.textColor = UIColorHex(666666);
        [self addSubview:_titleLabel];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bounds;
        [button addTarget:self action:@selector(checkDetails:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

- (void)setGoodsSum:(NSNumber *)goodsSum {
    _goodsSum = goodsSum;
    _titleLabel.text = [NSString stringWithFormat:@"共%@件商品",_goodsSum];
    [_titleLabel sizeToFit];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.centerY = self.centerY;
}

- (void)checkDetails:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (!sender.selected) {
        _sortImgView.image = IMAGE_NAMED(@"向上收起");
        if (_checkDetailBlock) {
            _checkDetailBlock(sender);
        }
        return;
    }
    _sortImgView.image = IMAGE_NAMED(@"向下展开");
    if (_checkDetailBlock) {
        _checkDetailBlock(sender);
    }
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end


@interface BonusSection ()


@property (nonatomic, strong) YYLabel *userableLabel;

@property (nonatomic, strong) YYLabel *detailLabel;

@property (nonatomic, strong) UIImageView *arrowImgView;

@end


@implementation BonusSection

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _arrowImgView = [UIImageView new];
        _arrowImgView.origin = CGPointMake(self.width-15-8, (self.height-14)/2.0);
        _arrowImgView.size = CGSizeMake(8, 14);
        _arrowImgView.image = IMAGE_NAMED(@"right_Arrow");
        [self addSubview:_arrowImgView];
        
        YYLabel *titleLabel = [YYLabel new];
        titleLabel.origin = CGPointMake(15, (self.height-18)/2.0);
        titleLabel.size = CGSizeMake(_arrowImgView.left-15*2, 18);
        titleLabel.font = SYSTEM_FONT(16);
        titleLabel.textColor = UIColorHex(666666);
        titleLabel.text = @"红包";
        [self addSubview:titleLabel];
        [titleLabel sizeToFit];

        _userableLabel = [YYLabel new];
        _userableLabel.origin = CGPointMake(titleLabel.right+8, (self.height-24)/2.0);
        _userableLabel.font = SYSTEM_FONT(12);
        _userableLabel.textColor = [UIColor whiteColor];
        _userableLabel.backgroundColor = kDefaultColor;
        _userableLabel.textAlignment = NSTextAlignmentCenter;
        _userableLabel.layer.cornerRadius = 4.0;
        [self addSubview:_userableLabel];
        
        _detailLabel = [YYLabel new];
        _detailLabel.size = CGSizeMake(_arrowImgView.left-_userableLabel.right, 14);
        _detailLabel.right = _arrowImgView.left-15;
        _detailLabel.top = (self.height-14)/2.0;
        _detailLabel.font = SYSTEM_FONT(13);
        _detailLabel.textColor = UIColorHex(999999);
        _detailLabel.text = @"满10减2";
        _detailLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_detailLabel];
        
        @weakify(self);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            @strongify(self);
            if (self.checkBonus) {
                self.checkBonus();
            }
        }];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)setBonusSum:(NSNumber *)bonusSum {
    _bonusSum = bonusSum;
    _userableLabel.text = [NSString stringWithFormat:@"%@个红包可用",bonusSum];
    CGSize size = [_userableLabel.text sizeWithAttributes:@{NSFontAttributeName:SYSTEM_FONT(12)}];
    _userableLabel.size = CGSizeMake(size.width+18, 24);
}

+ (BonusSection *)header {
    BonusSection *header = [[BonusSection alloc]initWithFrame:({
        CGRect rect = {0,0,kScreenWidth,[SectionHeader height]};
        rect;
    })];
    return header;
}


- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end

@interface SumSection ()

@property (nonatomic, strong) YYLabel *sumLabel;

@end

@implementation SumSection

+ (SumSection *)header {
    SumSection *header = [[SumSection alloc]initWithFrame:({
        CGRect rect = {0,0,kScreenWidth,[SectionHeader height]};
        rect;
    })];
    return header;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        YYLabel *titleLabel = [YYLabel new];
        titleLabel.origin = CGPointMake(15, (self.height-18)/2.0);
        titleLabel.size = CGSizeMake(100, 18);
        titleLabel.font = SYSTEM_FONT(16);
        titleLabel.textColor = UIColorHex(666666);
        titleLabel.text = @"商品金额";
        [self addSubview:titleLabel];
        [titleLabel sizeToFit];

        _sumLabel = [YYLabel new];
        _sumLabel.font = SYSTEM_FONT(15);
        _sumLabel.textColor = kDefaultColor;
        _sumLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_sumLabel];
        
    }
    return self;
}

- (void)setMoneySum:(NSNumber *)moneySum {
    _moneySum = moneySum;
     NSString *sum = [NSString stringWithFormat:@"%@元",moneySum];
     CGSize size = [sum sizeWithAttributes:@{NSFontAttributeName:SYSTEM_FONT(15)}];
     _sumLabel.origin = CGPointMake(self.width-15-size.width, (self.height-16)/2.0);
     _sumLabel.size = CGSizeMake(size.width, 16);
    _sumLabel.text = sum;
    [_sumLabel sizeToFit];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end















