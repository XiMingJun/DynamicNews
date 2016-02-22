//
//  DynamicNewsView.m
//  DynamicNews
//
//  Created by wangjian on 15/8/6.
//  Copyright (c) 2015年 qhfax. All rights reserved.
//

#import "DynamicNewsView.h"

# define TIME_FONT [UIFont systemFontOfSize:12.0]
# define TITLE_FONT [UIFont systemFontOfSize:14.0]
@interface DynamicNewsView()
{
    long _index;/**索引*/
}

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIView *upView;/**两个view做动画*/
@property (nonatomic, strong) UILabel *upLabel_left;/**显示左侧标题*/
@property (nonatomic, strong) UILabel *upLabel_right;/**显示右侧时间*/

@property (nonatomic, strong) UIView *downView;
@property (nonatomic, strong) UILabel *downLabel_left;
@property (nonatomic, strong) UILabel *downLabel_right;

@property (nonatomic, strong) UIButton *moreNewsBtn;//【查看更多】按钮
@end

@implementation DynamicNewsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        self.layer.cornerRadius = 4.0;
        self.clipsToBounds = YES;
        _index = 0;
        [self buildUI];
        
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
    return self;
}
-(void)buildUI
{
    self.backgroundColor = [UIColor whiteColor];
    //查看更多按钮
    self.moreNewsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreNewsBtn.frame = CGRectMake(self.frame.size.width - 65, 5,60, self.frame.size.height - 5*2);
    self.moreNewsBtn.layer.cornerRadius = self.moreNewsBtn.frame.size.height/2;
    self.moreNewsBtn.layer.borderColor = [[UIColor blackColor] CGColor];
    self.moreNewsBtn.layer.borderWidth = 1.0f;
    self.moreNewsBtn.clipsToBounds = YES;
    [self.moreNewsBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [self.moreNewsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.moreNewsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.moreNewsBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
    [self.moreNewsBtn addTarget:self
                         action:@selector(moreBtnAction:)
               forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.moreNewsBtn];
    
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.height - 5*2, self.frame.size.height - 5*2)];
    iconImgView.backgroundColor = [UIColor blueColor];
    [self addSubview:iconImgView];
    
    self.upView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImgView.frame)+5, 0,self.frame.size.width - 70 - CGRectGetMaxX(iconImgView.frame)-5, self.frame.size.height)];
    self.upView.backgroundColor = [UIColor clearColor];
    self.upView.userInteractionEnabled = YES;
    [self addSubview:self.upView];
    
    self.upLabel_left = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.upView.frame.size.width - 70, self.upView.frame.size.height)];
    self.upLabel_left.backgroundColor = [UIColor greenColor];
    self.upLabel_left.textAlignment = NSTextAlignmentLeft;
    self.upLabel_left.font = TITLE_FONT;
    self.upLabel_left.userInteractionEnabled = YES;
    self.upLabel_left.text = [NSString stringWithFormat:@"%ld",_index];
    [self.upView addSubview:self.upLabel_left];
    
    self.upLabel_right = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.upLabel_left.frame)+5, 0, 65, self.upView.frame.size.height)];
    self.upLabel_right.backgroundColor = [UIColor cyanColor];
    self.upLabel_right.textAlignment = NSTextAlignmentRight;
    self.upLabel_right.userInteractionEnabled = YES;
    self.upLabel_right.font = TIME_FONT;
    self.upLabel_right.text = [NSString stringWithFormat:@"2015-08-30"];
    [self.upView addSubview:self.upLabel_right];
    
    
    
    self.downView = [[UILabel alloc] initWithFrame:CGRectMake(self.upView.frame.origin.x,self.frame.size.height, self.upView.frame.size.width,self.upView.frame.size.height)];
    self.downView.backgroundColor = [UIColor clearColor];
    self.downView.userInteractionEnabled = YES;
    _index +=1;
    [self addSubview:self.downView];
    self.downLabel_left = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,self.upLabel_left.frame.size.width, self.upView.frame.size.height)];
    self.downLabel_left.backgroundColor = [UIColor brownColor];
    self.downLabel_left.textAlignment = NSTextAlignmentLeft;
    self.downLabel_left.userInteractionEnabled = YES;
    self.downLabel_left.font = TITLE_FONT;
    self.downLabel_left.text = [NSString stringWithFormat:@"%ld",_index];
    [self.downView addSubview:self.downLabel_left];
    
    self.downLabel_right = [[UILabel alloc] initWithFrame:CGRectMake(self.upLabel_right.frame.origin.x, 0, self.upLabel_right.frame.size.width, self.downView.frame.size.height)];
    self.downLabel_right.backgroundColor = [UIColor magentaColor];
    self.downLabel_right.textAlignment = NSTextAlignmentRight;
    self.downLabel_right.userInteractionEnabled = YES;
    self.downLabel_right.font = TIME_FONT;
    self.downLabel_right.text = [NSString stringWithFormat:@"2015-08-31"];
    [self.downView addSubview:self.downLabel_right];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(detailNews)];
    [self.upLabel_left addGestureRecognizer:tapGesture];
    [self.downLabel_left addGestureRecognizer:tapGesture];
}
- (NSTimer *)timer
{
    if (_timer == nil)
    {
        _timer = [NSTimer timerWithTimeInterval:5.0f
                                         target:self
                                       selector:@selector(timerAction)
                                       userInfo:nil
                                        repeats:YES];
    }
    return _timer;
}
#pragma mark--------action
//点击更多
-(void)moreBtnAction:(UIButton *)sender
{
        self.dynamicBlock(-1);
    
}
//新闻详情
-(void)detailNews
{
        self.dynamicBlock(_index);
    
}
-(void)timerAction
{
    [UIView animateWithDuration:2.0f
                     animations:^{
                         [self moveLabelWithAnimationComplet:NO];
                     }
                     completion:^(BOOL finished) {
                         [self moveLabelWithAnimationComplet:YES];
                     }];
}
-(void)moveLabelWithAnimationComplet:(BOOL)complet
{
    CGRect upRect = self.upView.frame;
    CGRect downRect = self.downView.frame;
    if (upRect.origin.y >= downRect.origin.y)
    {
        //downLabel 显示，uplabel在下边，向上移动
        upRect.origin.y = 0;
        self.upView.frame = upRect;
        if (complet)
        {
            downRect.origin.y = downRect.size.height;
            _index+=1;
            self.downLabel_left.text = [NSString stringWithFormat:@"%ld",_index];
        }else
        {
            downRect.origin.y = -downRect.size.height;
        }
        self.downView.frame = downRect;
    }else
    {
        //uplabel显示 ，downlabel在下边，向上移动
        downRect.origin.y = 0;
        self.downView.frame = downRect;
        if (complet)
        {
            upRect.origin.y = upRect.size.height;
            _index+=1;
            self.upLabel_left.text = [NSString stringWithFormat:@"%ld",_index];
        }else
        {
            upRect.origin.y = -upRect.size.height;
        }
        self.upView.frame = upRect;
    }
}
- (void)invalidateTimer
{
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }else{
        self.timer = nil;
    }
    
}
-(void)dealloc
{
    [self invalidateTimer];
}
@end
