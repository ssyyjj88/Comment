//
//  YMTextData.h
//  Comment
//
//  Created by 孙玉娟 on 16/7/27.
//  Copyright © 2016年 孙玉娟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFMessageBody.h"

@interface YMTextData : NSObject

@property (nonatomic,strong) WFMessageBody  *messageBody;
@property (nonatomic,strong) NSMutableArray *replyDataSource;//回复内容数据源（未处理）

#pragma mark - 高度部分
@property (nonatomic,assign) float           replyHeight;//回复高度


@property (nonatomic,strong) NSMutableArray *completionReplySource;//回复内容数据源（处理）
@property (nonatomic,strong) NSMutableArray *attributedDataReply;//回复部分附带的点击区域数组
@property (nonatomic,strong) NSMutableArray *attributedDataShuoshuo;//说说部分附带的点击区域数组
@property (nonatomic,strong) NSMutableArray *attributedDataFavour;//点赞部分附带的点击区域数组
@property (nonatomic,strong) NSMutableArray *defineAttrData;//自行添加 元素为每条回复中的自行添加的range组成的数组 如：第一条回复有（0，2）和（5，2） 第二条为（0，2）。。。。

- (id)initWithMessage:(WFMessageBody *)messageBody;

/**
 *  计算高度
 *
 *  @param sizeWidth view 宽度
 *
 *  @return 返回高度
 */
- (float) calculateReplyHeightWithWidth:(float)sizeWidth;

@end
