//
//  ViewController.h
//  test
//
//  Created by 陈测一 on 2024/2/28.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end


#define NSLog(format, ...) printf("[%s] %s [第%d行] %s\n", [[[NSDate.date description] substringWithRange:NSMakeRange(11, 8)] UTF8String], __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#define KGLog NSLog
