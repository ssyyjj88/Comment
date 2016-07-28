//
//  WFReplyBody.h
//  Comment
//
//  Created by 孙玉娟 on 16/7/27.
//  Copyright © 2016年 孙玉娟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFReplyBody : NSObject

/**
 *  评论者
 */
@property (nonatomic,copy) NSString *replyUser;


/**
 *  回复该评论者的人
 */
@property (nonatomic,copy) NSString *repliedUser;

/**
 *  回复内容
 */
@property (nonatomic,copy) NSString *replyInfo;

@end
