//
//  CommentHeaderView.m
//  News
//
//  Created by pdmi on 2017/5/19.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "CommentHeaderView.h"
#import "YYLabel.h"
@interface CommentHeaderView ()

/** 头像 */
@property (nonatomic , weak) UIImageView *avatarView;

/** 昵称 */
@property (nonatomic , weak) YYLabel *nicknameLable;

/** 点赞 */
@property (nonatomic , weak) UIButton *thumbBtn;

/** 更多 */
@property (nonatomic , weak) UIButton *moreBtn;

/** 创建时间 */
@property (nonatomic , weak) YYLabel *createTimeLabel;

/** ContentView */
@property (nonatomic , weak) UIView *contentBaseView;

/** 文本内容 */
@property (nonatomic , weak) YYLabel *contentLabel;


@end


@implementation CommentHeaderView
+ (instancetype)topicHeaderView
{
    return [[self alloc] init];
}

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TopicHeader";
    CommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        // 缓存池中没有, 自己创建
        NSLog(@"....创建表头...");
        header = [[self alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 初始化
        [self _setup];
        
        // 创建自控制器
        [self setupSubViews];
        
        // 布局子控件
        [self _makeSubViewsConstraints];
    }
    return self;
}
#pragma mark - 创建自控制器
- (void)setupSubViews
{
    
    // 整个宽度
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 头像
    UIImageView *avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    
    avatarView.layer.cornerRadius = 30*.5f;
    // 这样写比较消耗性能
    avatarView.layer.masksToBounds = YES;
    
    self.avatarView = avatarView;
    [self.contentView addSubview:avatarView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_avatarOrNicknameDidClicked)];
    [avatarView addGestureRecognizer:tap];
    
    
    // 昵称
    YYLabel *nicknameLable = [[YYLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(avatarView.frame)+10, CGRectGetMinY(avatarView.frame), 200, 20)];
    nicknameLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:nicknameLable];
    self.nicknameLable = nicknameLable;
    
    __weak typeof(self) weakSelf = self;
    nicknameLable.textTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
       // [weakSelf _avatarOrNicknameDidClicked];
    };
    
    // 点赞按钮
    UIButton *thumbBtn = [[UIButton alloc] initWithFrame:CGRectMake(width-50, CGRectGetMinY(avatarView.frame), 30, 30)];
    thumbBtn.adjustsImageWhenHighlighted = NO;
    [thumbBtn setImage:[UIImage imageNamed:@"comment_zan_nor"]  forState:UIControlStateNormal];
    [thumbBtn setImage:[UIImage imageNamed:@"comment_zan_high"]  forState:UIControlStateSelected];
    [thumbBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [thumbBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
    [thumbBtn addTarget:self action:@selector(_thumbBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    thumbBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:thumbBtn];
    self.thumbBtn = thumbBtn;
    
    
    
    // 时间
    YYLabel *createTimeLabel = [[YYLabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nicknameLable.frame), CGRectGetMaxY(nicknameLable.frame)+5, 200, 20)];
    createTimeLabel.textAlignment = NSTextAlignmentLeft;

    [self.contentView addSubview:createTimeLabel];
    self.createTimeLabel = createTimeLabel;
//    createTimeLabel.textTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        [weakSelf _contentTextDidClicked];
//    };
    
    
    // 文本
    YYLabel *contentLabel = [[YYLabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(createTimeLabel.frame), CGRectGetMaxY(<#CGRect rect#>), <#CGFloat width#>, <#CGFloat height#>)];
    // 设置文本的额外区域，修复用户点击文本没有效果
    UIEdgeInsets textContainerInset = contentLabel.textContainerInset;
    textContainerInset.top = MHTopicVerticalSpace;
    textContainerInset.bottom = MHTopicVerticalSpace;
    contentLabel.textContainerInset = textContainerInset;
    
    contentLabel.numberOfLines = 0 ;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    contentLabel.textTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        [weakSelf _contentTextDidClicked];
    };
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
