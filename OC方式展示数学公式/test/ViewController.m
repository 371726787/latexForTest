//
//  ViewController.m
//  LCModalHelperDemo
//
//  Created by 陈测一 on 2018/1/13.
//  Copyright © 2018年 陈测一. All rights reserved.
//

#import "ViewController.h"

#import "KGLaTeXTool.h"

@interface ViewController ()
/**
 *  <#备注#>
 */
@property (nonatomic, weak) UILabel* label;
/**
 *  <#备注#>
 */
@property (nonatomic, strong) NSArray * textArray;
/**
 *  <#备注#>
 */
@property (nonatomic, copy) NSString * totalText;
/**
 *  <#备注#>
 */
@property (nonatomic, assign) CGFloat maxWidth;

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.blackColor;
    
    self.maxWidth = 300;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 300, 0)];
    label.numberOfLines = 0;
    label.layer.geometryFlipped = NO;
    [self.view addSubview:label];
    self.label = label;
    
    
    self.textArray = @[
        @"\\[\n   4\\text{Fe} + 3\\text{O}_2 \\rightarrow 2\\text{Fe}_2\\text{O}_3\n   \\]\n",
        @"\\[ g = \\frac{G \\cdot M}{R^2} \\]\n\n",
        @"\\[ (i\\gamma^\\mu \\partial_\\mu - m)\\psi = 0 \\]\n\n",
        @"$ \\because a==b $",
        @"皮尔逊相似度是一种用于衡量两个变量之间线性相关程度的统计方法。",
        @"其公式为：\n\n",
        @"\\[ r = \\frac{\\sum{(x_i - \\bar{x})(y_i - ",
        @"\\bar{y})}}{\\sqrt{\\sum{(x_i - \\bar{x})^2} \\sum{(y_i - \\bar{y})^2}}} \\]\n\n",
        @"其中：\n",
        @"- \\( x_i \\) 和 \\( y_i \\)分别是两个变量的观测值。\n",
        @"- \\( \\bar{x} \\) 和 \\( \\bar{y} \\) 分别是两个变量的平均值。\n",
        @"- \\( r \\) 的取值范围为 -1 到 1，1 表示完全正相关，",
        @"-1 表示完全负相关，",
        @"0 表示无线性相关。\n\n",
        @"皮尔逊相似度常用于统计分析、推荐系统等领域，",
        @"用来评估变量之间的线性关系。",
    ];
    
    __weak typeof(self) weakSelf = self;
    __block NSInteger index = 0;
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (weakSelf.textArray.count > index) {
            [weakSelf testOther:index];
        }else{
            [timer invalidate];
        }
        index++;
    }];
    [NSRunLoop.mainRunLoop addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)testOther:(NSInteger)index{
    
    NSString * text = [NSString stringWithFormat:@"%@%@", self.totalText ? : @"", self.textArray[index]];
    self.totalText = text;
    
    NSAttributedString * attrString = [GetLaTeXTool attributedStringWithLeTeXString:self.totalText font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] textColor:UIColor.orangeColor maxWidth:self.maxWidth];
    self.label.attributedText = attrString;
    
    // 计算尺寸
//    CGSize maxSize = CGSizeMake(self.maxWidth, CGFLOAT_MAX);
//    CGRect boundingRect = [attrString boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) context:nil];
//    
//    CGRect frame = self.label.frame;
//    frame.size.height = ceil(boundingRect.size.height);
//    self.label.frame = frame;
//    
//    KGLog(@"-------->第一种：%f", ceil(boundingRect.size.height));
    
    CGSize size = [self.label sizeThatFits:CGSizeMake(self.maxWidth, CGFLOAT_MAX)];
    CGRect frame = self.label.frame;
    frame.size.height = ceil(size.height) + self.label.font.lineHeight;
    self.label.frame = frame;
    KGLog(@"-------->第二种：%f--%f", self.label.frame.size.width, self.label.frame.size.height);
    
//    [self.label sizeToFit];
//    KGLog(@"-------->第三种：%f--%f", self.label.frame.size.width, self.label.frame.size.height);
    
}

@end

