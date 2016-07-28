//
//  WFTextView.h
//  Comment
//
//  Created by 孙玉娟 on 16/7/27.
//  Copyright © 2016年 孙玉娟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WFCoretextDelegate <NSObject>

- (void)clickWFCoretext:(NSString *)clickString replyIndex:(NSInteger)index;

- (void)longClickWFCoretext:(NSString *)clickString replyIndex:(NSInteger)index;

@end

@interface WFTextView : UIView

@property (nonatomic,strong) NSAttributedString *attrEmotionString;
@property (nonatomic,strong) NSArray *emotionNames;
@property (nonatomic,strong) NSMutableArray *attributedData;
@property (nonatomic,assign) int textLine;
@property (nonatomic,assign) id<WFCoretextDelegate>delegate;
@property (nonatomic,assign) CFIndex limitCharIndex;//限制行的最后一个char的index
@property (nonatomic,assign) BOOL canClickAll;//是否可点击整段文字
@property (nonatomic,assign) NSInteger replyIndex;

@property (nonatomic,strong) UIColor *textColor;

- (void)setOldString:(NSString *)oldString andNewString:(NSString *)newString;

- (int)getTextLines;

- (float)getTextHeight;

@end
