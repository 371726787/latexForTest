//
//  KGLaTeXTool.h
//  test
//
//  Created by 陈测一 on 2025/3/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define GetLaTeXTool ([KGLaTeXTool sharedInstance])

@interface KGLaTeXTool : NSObject
/**
 *  单例
 */
+ (instancetype)sharedInstance;
/**
 *  添加一些不支持的字符
 */
- (void)addLatexSymbol:(NSString *)symbol andEscapedString:(NSString *)escapedString;
/**
 *  把latex字符串转成富文本去展示
 */
- (NSAttributedString *)attributedStringWithLeTeXString:(NSString *)leTeXString font:(UIFont *)font textColor:(UIColor *)textColor maxWidth:(CGFloat)maxWidth;

@end

NS_ASSUME_NONNULL_END
