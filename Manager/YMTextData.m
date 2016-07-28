//
//  YMTextData.m
//  Comment
//
//  Created by 孙玉娟 on 16/7/27.
//  Copyright © 2016年 孙玉娟. All rights reserved.
//

#import "YMTextData.h"
#import "ContantHead.h"
#import "ILRegularExpressionManager.h"
#import "NSString+NSString_ILExtension.h"
#import "WFReplyBody.h"
#import "WFTextView.h"

@implementation YMTextData
{
    int tempInt;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.completionReplySource = [[NSMutableArray alloc] init];
        self.attributedDataReply = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setMessageBody:(WFMessageBody *)messageBody{
    _messageBody = messageBody;
    _defineAttrData = [self findAttrWith:messageBody.posterReplies];
    _replyDataSource = messageBody.posterReplies;
}

- (NSMutableArray *)findAttrWith:(NSMutableArray *)replies
{
    NSMutableArray *feedBackArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < replies.count; i++)
    {
        WFReplyBody *replyBody = (WFReplyBody *)[replies objectAtIndex:i];
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        if ([replyBody.repliedUser isEqualToString:@""]) {
            NSString *range = NSStringFromRange(NSMakeRange(0, replyBody.replyUser.length));
            [tempArr addObject:range];
        }else{
            NSString *range1 = NSStringFromRange(NSMakeRange(0, replyBody.replyUser.length));
            NSString *range2 = NSStringFromRange(NSMakeRange(replyBody.replyUser.length + [@" Reply " length], replyBody.repliedUser.length));
            [tempArr addObject:range1];
            [tempArr addObject:range2];
        }
        [feedBackArray addObject:tempArr];
    }
    return feedBackArray;
}


//计算replyview高度
- (float) calculateReplyHeightWithWidth:(float)sizeWidth{
    
    float height = .0f;
    
    for (int i = 0; i < self.replyDataSource.count; i ++ ) {
        
        tempInt = i;
        
        WFReplyBody *body = (WFReplyBody *)[self.replyDataSource objectAtIndex:i];
        
        NSString *matchString;
        
        if ([body.repliedUser isEqualToString:@""]) {
            matchString = [NSString stringWithFormat:@"%@:%@",body.replyUser,body.replyInfo];
            
        }else{
            matchString = [NSString stringWithFormat:@"%@ Reply %@:%@",body.replyUser,body.repliedUser,body.replyInfo];
            
        }
        NSArray *itemIndexs = [ILRegularExpressionManager itemIndexesWithPattern:EmotionItemPattern inString:matchString];
        
        NSString *newString = [matchString replaceCharactersAtIndexes:itemIndexs
                                                           withString:PlaceHolder];
        //存新的
        [self.completionReplySource addObject:newString];
        
        [self matchString:newString];
        
        WFTextView *_ilcoreText = [[WFTextView alloc] initWithFrame:CGRectMake(offSet_X,10, sizeWidth - offSet_X * 2, 0)];
        
        [_ilcoreText setOldString:matchString andNewString:newString];
        
        height =  height + [_ilcoreText getTextHeight] + 5;
        
    }
    
    return height;
    
}

- (void)matchString:(NSString *)dataSourceString
{
    NSMutableArray *totalArr = [NSMutableArray arrayWithCapacity:0];
    
    //**********号码******
    
    NSMutableArray *mobileLink = [ILRegularExpressionManager matchMobileLink:dataSourceString];
    for (int i = 0; i < mobileLink.count; i ++) {
        
        [totalArr addObject:[mobileLink objectAtIndex:i]];
    }
    
    //*************************
    
    
    //***********匹配网址*********
    
    NSMutableArray *webLink = [ILRegularExpressionManager matchWebLink:dataSourceString];
    for (int i = 0; i < webLink.count; i ++) {
        
        [totalArr addObject:[webLink objectAtIndex:i]];
    }
    
    //******自行添加**********
    
    if (_defineAttrData.count != 0) {
        NSArray *tArr = [_defineAttrData objectAtIndex:tempInt];
        for (int i = 0; i < [tArr count]; i ++) {
            NSString *string = [dataSourceString substringWithRange:NSRangeFromString([tArr objectAtIndex:i])];
            [totalArr addObject:[NSDictionary dictionaryWithObject:string forKey:NSStringFromRange(NSRangeFromString([tArr objectAtIndex:i]))]];
        }
        
    }
    
    
    //***********************
    [self.attributedDataReply addObject:totalArr];
}

@end
