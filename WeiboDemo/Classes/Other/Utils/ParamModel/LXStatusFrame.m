//
//  LXStatusFrame.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/10.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXStatusFrame.h"
#import "LXStatus.h"
#import "LXUser.h"

@implementation LXStatusFrame

- (void)setStatus:(LXStatus *)status{
    _status = status;
    
    [self initOriginalViewFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (status.retweeted_status) {
        [self initRetweetViewFrame];
        
        toolBarY = CGRectGetMaxY(_reTweetViewFrame);
    }
    
    CGFloat toolBarX = 0;
    CGFloat toolBarW = ScreenW;
    CGFloat toolBarH = 35;
    _toolBarViewFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    _cellHeight = CGRectGetMaxY(_toolBarViewFrame);
}

- (void)initOriginalViewFrame{
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    
    CGFloat imageX = StatusCellMargin;
    CGFloat imageY = StatusCellMargin;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + StatusCellMargin;
    CGFloat nameY = imageY;
    attrs[NSFontAttributeName] = CellNameFont;
    CGSize nameSize = [_status.user.name sizeWithAttributes:attrs];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    if (_status.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + StatusCellMargin;
        CGFloat vipY = imageY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(_originalNameFrame) + StatusCellMargin*0.5;
    attrs[NSFontAttributeName] = CellTimeFont;
    CGSize timeSize = [_status.created_at sizeWithAttributes:attrs];
    _originalTimeFrame = (CGRect){{timeX,timeY},{60, timeSize.height}};
    
    CGFloat sourceX = CGRectGetMaxX(_originalTimeFrame) + StatusCellMargin;
    CGFloat sourceY = timeY;
    attrs[NSFontAttributeName] = CellSourceFont;
    CGSize sourceSize = [_status.source sizeWithAttributes:attrs];
    _originalSourceFrame = (CGRect){{sourceX,sourceY},sourceSize};
    
    CGFloat textX = StatusCellMargin;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + StatusCellMargin;
    CGFloat textW = ScreenW - 2 *StatusCellMargin;
    attrs[NSFontAttributeName] = CellTextFont;
    CGRect textSize = [_status.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrs context:nil];
    _originalTextFrame = (CGRect){{textX,textY},textSize.size};
    
    
    CGFloat originalH = CGRectGetMaxY(_originalTextFrame) + StatusCellMargin;
    if (_status.pic_urls.count) {
        CGFloat photosX = StatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + StatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:(int)_status.pic_urls.count];
        
        _originalPhotosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        originalH = CGRectGetMaxY(_originalPhotosFrame) + StatusCellMargin;
    }
    
    CGFloat originalX = 0;
    CGFloat originalY = StatusCellMargin;
    CGFloat originalW = ScreenW;
    
    _originalViewFrame = CGRectMake(originalX, originalY, originalW, originalH);
    
}

- (CGSize)photosSizeWithCount:(int)count{
    
    int column = count == 4 ? 2 : 3;
    int rows = (count-1) / column + 1;
    CGFloat photoWH = 80;
    CGFloat w = column * photoWH + (column - 1)*StatusCellMargin;
    CGFloat h = rows * photoWH + (rows - 1)*StatusCellMargin;
    
    return CGSizeMake(w, h);
}

- (void)initRetweetViewFrame{
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    
    CGFloat nameX = StatusCellMargin;
    CGFloat nameY = StatusCellMargin;
    attrs[NSFontAttributeName] = CellNameFont;
    CGSize nameSize = [_status.retweeted_status.user.name sizeWithAttributes:attrs];
    _reTweetNameFrame = (CGRect){{nameX,nameY},{ScreenW-2*StatusCellMargin, nameSize.height}};
    
    CGFloat textX = StatusCellMargin;
    CGFloat textY = CGRectGetMaxY(_reTweetNameFrame) + StatusCellMargin;
    CGFloat textW = ScreenW - 2 *StatusCellMargin;
    attrs[NSFontAttributeName] = CellTextFont;
    CGRect textSize = [_status.retweeted_status.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
    _reTweetTextFrame = (CGRect){{textX,textY},textSize.size};
    
    CGFloat retweetH = CGRectGetMaxY(_reTweetTextFrame) + StatusCellMargin;
    
    int photoCount = (int)_status.retweeted_status.pic_urls.count;
    if (photoCount) {
        CGFloat photosX = StatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_reTweetTextFrame) + StatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:photoCount];
        
        _reTweetPhotosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        retweetH = CGRectGetMaxY(_reTweetPhotosFrame) + StatusCellMargin;
    }
    
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = ScreenW;
    _reTweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
}

@end
