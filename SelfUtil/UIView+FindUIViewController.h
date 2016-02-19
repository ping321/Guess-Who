//  Guess-Who
//
//  Created by 冯颐平 on 16/2/19.
//  Copyright © 2016年 冯颐平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FindUIViewController)

- (UIViewController *) firstAvailableUIViewController;
- (id) traverseResponderChainForUIViewController;

@end
