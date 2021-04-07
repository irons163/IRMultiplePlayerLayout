//
//  VideoContentCell.h
//  Texture
//
//  Copyright (c) Facebook, Inc. and its affiliates.  All rights reserved.
//  Changes after 4/13/2017 are: Copyright (c) Pinterest, Inc.  All rights reserved.
//  Licensed under Apache 2.0: http://www.apache.org/licenses/LICENSE-2.0
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "VideoModel.h"
#import <IRPlayer/IRPlayer.h>

@interface VideoContentCell : ASCellNode

@property (readonly) IRPlayerImp *player;

- (instancetype)initWithVideoObject:(VideoModel *)video;

@end
