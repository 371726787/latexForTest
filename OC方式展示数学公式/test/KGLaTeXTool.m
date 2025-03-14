//
//  KGLaTeXTool.m
//  test
//
//  Created by 陈测一 on 2025/3/14.
//

#import "KGLaTeXTool.h"

#import "MTMathAtomFactory.h"
#import "IosMath.h"

@interface KGLaTeXModel : NSObject
/**
 *  文本内容
 */
@property (nonatomic, copy) NSString * text;
/**
 *  所在范围
 */
@property (nonatomic, assign) NSRange range;
/**
 *  是否是数学公式
 */
@property (nonatomic, assign) BOOL isLaTeX;

@end

@implementation KGLaTeXModel

@end

@interface KGLaTeXTool()
/**
 *  展示的最大宽度
 */
@property (nonatomic, assign) CGFloat maxWidth;

@end

@implementation KGLaTeXTool

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static id tool;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
    });
    return tool;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //添加iosMath一些不支持的
        [self addLatexSymbol:@"because" andEscapedString:@"∵"];
        [self addLatexSymbol:@"text" andEscapedString:@""];
    }
    return self;
}

- (NSAttributedString *)attributedStringWithLeTeXString:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor maxWidth:(CGFloat)maxWidth{
    
    self.maxWidth = maxWidth;
    
    text = [self replaceForLaTeXOriString:text];
    
    NSArray * tmpArr = [self matchString:text toRegexString:@"\\$.*?\\$"];
    
    NSMutableAttributedString * totalAttrString = [[NSMutableAttributedString alloc] init];
    for (KGLaTeXModel * model in tmpArr) {
        NSMutableAttributedString * attrString;
        if (model.isLaTeX) {
            attrString = [self getMaxLatexWithString:model.text font:font textColor:textColor].mutableCopy;
        }
        if (attrString) {
            [totalAttrString appendAttributedString:attrString];
        }else{
            attrString = [[NSMutableAttributedString alloc] initWithString:model.text];
            [attrString addAttributes:@{
                NSFontAttributeName : font,
                NSForegroundColorAttributeName : textColor,
            } range:NSMakeRange(0, model.text.length)];
            [totalAttrString appendAttributedString:attrString];
        }
    }
    return totalAttrString;
}

- (NSString *)replaceForLaTeXOriString:(NSString *)oldValue{
    //iosMath不支持\(、\)、\[、\]，将这两种转为$来匹配
    NSString * pattern = @"(\\\\\\))|(\\\\\\()|(\\\\\\[\\s*)|(\\s*\\\\])";
    
    NSError *error = nil;
    // 创建正则表达式对象
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    
    // 执行替换，将匹配到的模式替换为 $
    NSString * newValue = [regex stringByReplacingMatchesInString:oldValue options:0 range:NSMakeRange(0, oldValue.length) withTemplate:@"$"];
    return newValue;
}

- (NSArray *)matchString:(NSString *)string toRegexString:(NSString *)regexStr{
    
    if(string.length == 0){
        return nil;
    }
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray * matches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    //match: 所有匹配到的字符,根据() 包含级
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSInteger location = 0;
    
    for (NSTextCheckingResult *match in matches) {
        //以正则中的(),划分成不同的匹配部分
        if (match.range.location == NSNotFound) {
            continue;
        }
        
        if (match.range.location != location) {
            NSRange range = NSMakeRange(location, match.range.location - location);
            KGLaTeXModel * model = [[KGLaTeXModel alloc] init];
            model.text = [string substringWithRange:range];
            model.range = range;
            model.isLaTeX = NO;
            [array addObject:model];
        }
        KGLaTeXModel * model = [[KGLaTeXModel alloc] init];
        model.text = [string substringWithRange:match.range];
        model.range = match.range;
        model.isLaTeX = YES;
        [array addObject:model];
        location = match.range.location + match.range.length;
    }
    
    if (location != string.length - 1) {
        NSRange range = NSMakeRange(location, string.length - location);
        KGLaTeXModel * model = [[KGLaTeXModel alloc] init];
        model.text = [string substringWithRange:range];
        model.range = range;
        model.isLaTeX = NO;
        [array addObject:model];
    }
    
    return array;
}

- (NSAttributedString *)getMaxLatexWithString:(NSString *)latexStr  font:(UIFont *)font textColor:(UIColor *)textColor{
    
    MTMathUILabel* label = [[MTMathUILabel alloc] init];
    label.fontSize = font.pointSize;
    label.textColor = textColor;
    label.latex = latexStr;
    
    CGSize size = [label sizeThatFits:CGSizeMake(self.maxWidth, MAXFLOAT)];
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return nil;
    }
    label.frame = CGRectMake(0, 0, size.width, size.height);
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height + 5)];
    [view addSubview:label];
    label.frame = CGRectMake(0, 0, size.width, size.height);
    
    NSTextAttachment * attach = [[NSTextAttachment alloc] init];
    attach.bounds = CGRectMake(0, -view.frame.size.height/2.0, view.frame.size.width, view.frame.size.height);
    attach.image = [self imageWithView:view size:view.frame.size];
    return [NSAttributedString attributedStringWithAttachment:attach];
}

- (void)addLatexSymbol:(NSString *)symbol andEscapedString:(NSString *)escapedString{
    //添加iosMath一些不支持的转义字符
    [MTMathAtomFactory addLatexSymbol:symbol value:[MTMathAtomFactory operatorWithName:escapedString limits:NO]];
}

- (UIImage *)imageWithView:(UIView *)view size:(CGSize)size{
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * reImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return reImage;
    
}

@end
