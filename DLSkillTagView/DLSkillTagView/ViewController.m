//
//  ViewController.m
//  DLSkillTagView
//
//  Created by FT_David on 2016/11/17.
//  Copyright © 2016年 FT_David. All rights reserved.
//

#import "ViewController.h"
#import "SKTagView.h"
#import "HexColors.h"

@interface ViewController ()<UIAlertViewDelegate>

@property (strong, nonatomic) SKTagView *tagView;
@property (strong, nonatomic) NSArray *colors;
@property(nonatomic,assign)NSUInteger originalButtonCount;

-(void)dl_setupTagView;
-(void)dl_configTag:(SKTag*)tag withIndex:(NSUInteger)index;

@end

@implementation ViewController
#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.colors = @[@"#FCBEBE", @"#FCBEBE", @"#FCBEBE", @"#FCBEBE", @"#FCBEBE"];
    self.colors = @[@"#7ecef4", @"#84ccc9", @"#88abda", @"#7dc1dd", @"#b6b8de"];
    [self dl_setupTagView];
}

#pragma mark - Private
- (void)dl_setupTagView {
    
    // 先移除掉所有
    [self.tagView removeAllTags];
    
    // 初始化
    self.tagView = [[SKTagView alloc] init];
    
    // 整个tagView对应其SuperView的上左下右距离
    self.tagView.padding = UIEdgeInsetsMake(1, 10, 1, 10);
    
    // 上下行之间的距离
    self.tagView.lineSpacing = 5;
    
    // item之间的距离
    self.tagView.interitemSpacing = 10;
    
    // 最大宽度
    //self.tagView.preferredMaxLayoutWidth = SCREEN_WIDTH;
    
    // 点击事件回调
    self.tagView.didTapTagAtIndex = ^(NSUInteger idx){
        
        NSLog(@"点击了第%ld个",idx);
        
    };
    
    // 获取刚才加入所有tag之后的内在高度
    
    CGFloat tagHeight = self.tagView.intrinsicContentSize.height;

    
    // 根据已经得到的内在高度给SKTagView创建frame
    
    self.tagView.frame = CGRectMake(0, 0, 400, 70);
    
    [self.tagView layoutSubviews];
    
    
    
    self.tagView = ({
        SKTagView *view = [SKTagView new];
        view.backgroundColor = [UIColor whiteColor];
        view.padding = UIEdgeInsetsMake(40, 20, 40, 20);
        view.interitemSpacing = 15;
        view.lineSpacing = 10;
        view.didTapTagAtIndex = ^(NSUInteger index){
            if (index == 0) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"输入技能" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
                [alertView show];
            }
            
             NSLog(@"点击了第%ld个",index);
        };
        view;
    });
#warning TODO 潜在的问题
    //self.tagView.frame = self.view.bounds;  //如果高度不够，只会显示一个
    self.tagView.frame = CGRectMake(0, 0, 320, 200);
    [self.view addSubview:self.tagView];
    
//    NSArray *tagsArray = @[@"+ 添加",@"Python", @"Javascript", @"Python", @"Swift", @"Go", @"Objective-C", @"C", @"PHP"];
    NSArray *tagsArray = @[@"+ 添加",@"Python",@"+ 添加",@"Python"];
    self.originalButtonCount = tagsArray.count;
    [tagsArray enumerateObjectsUsingBlock: ^(NSString *text, NSUInteger idx, BOOL *stop) {
        SKTag *tag = [SKTag tagWithText: text];
        if (idx == 0) {
            tag.textColor = [UIColor hx_colorWithHexString: self.colors[idx % self.colors.count]];
            tag.borderColor = tag.textColor;
            tag.borderWidth = 1;
            tag.fontSize = 15;
            //tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
            tag.padding = UIEdgeInsetsMake(1, 10, 1, 10);
            tag.nrmColor = [UIColor clearColor];
            tag.cornerRadius = 5;
        }else{
           [self dl_configTag:tag withIndex:idx];
        }
        [self.tagView addTag:tag];
    }];
}

-(void)dl_configTag:(SKTag *)tag withIndex:(NSUInteger)index
{
    tag.textColor = [UIColor whiteColor];
    tag.fontSize = 15;
    //tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
    tag.padding = UIEdgeInsetsMake(1, 10, 1, 10);
    tag.nrmColor = [UIColor hx_colorWithHexString: self.colors[index % self.colors.count]];
    tag.cornerRadius = 5;
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        SKTag *tag = [SKTag tagWithText: [alertView textFieldAtIndex:0].text];
        [self dl_configTag:tag withIndex:self.originalButtonCount];
        [self.tagView insertTag:tag atIndex:1];
        self.originalButtonCount ++ ;
    }
}




@end
