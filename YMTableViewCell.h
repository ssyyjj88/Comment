//
//  YMTableViewCell.h
//  Comment
//
//  Created by 孙玉娟 on 16/7/27.
//  Copyright © 2016年 孙玉娟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMTextData.h"
#import "WFTextView.h"

@protocol cellDelegate <NSObject>

- (void)showImageViewWithImageViews:(NSArray *)imageViews byClickWhich:(NSInteger)clickTag;
- (void)clickRichText:(NSInteger)index replyIndex:(NSInteger)replyIndex;
- (void)longClickRichText:(NSInteger)index replyIndex:(NSInteger)replyIndex;

@end

@interface YMTableViewCell : UITableViewCell<WFCoretextDelegate>

@property (nonatomic,weak) id<cellDelegate> delegate;
- (void)setYMViewWith:(YMTextData *)ymData;

@property (nonatomic,strong) NSMutableArray * ymTextArray;

@property (nonatomic,assign) NSInteger stamp;

@end
