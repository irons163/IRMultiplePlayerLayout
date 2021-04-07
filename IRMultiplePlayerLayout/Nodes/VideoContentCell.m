//
//  VideoContentCell.m
//  Texture
//
//  Copyright (c) Facebook, Inc. and its affiliates.  All rights reserved.
//  Changes after 4/13/2017 are: Copyright (c) Pinterest, Inc.  All rights reserved.
//  Licensed under Apache 2.0: http://www.apache.org/licenses/LICENSE-2.0
//

#import "VideoContentCell.h"

#import <AsyncDisplayKit/ASVideoPlayerNode.h>

#import "Utilities.h"

#import <IRGLView.h>

#define AVATAR_IMAGE_HEIGHT     30
#define HORIZONTAL_BUFFER       10
#define VERTICAL_BUFFER         5

@interface VideoContentCell () <ASVideoPlayerNodeDelegate>

@property BOOL muted;

@end

@implementation VideoContentCell {
    VideoModel *_videoModel;
    ASTextNode *_titleNode;
    ASNetworkImageNode *_avatarNode;
    ASDisplayNode *_videoPlayerNode;
    ASTextNode *_likeButtonNode;
}

- (instancetype)initWithVideoObject:(VideoModel *)video {
    self = [super init];
    if (self) {
        _videoModel = video;
        
        _videoPlayerNode = [[ASDisplayNode alloc] initWithViewBlock:^UIView * _Nonnull{
            self->_player = [IRPlayerImp player]; // main thread
            __block UIView *view = nil;
            
            view = self->_player.view;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self->_player.decoder = [IRPlayerDecoder FFmpegDecoder];
                [self->_player replaceVideoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"i-see-fire" ofType:@"mp4"]]];
                [self->_player play];
                self->_videoPlayerNode.backgroundColor = [UIColor blackColor];
            });
            
            view.frame = CGRectMake(0, 0, self->_videoPlayerNode.style.width.value, self->_videoPlayerNode.style.height.value);
            //                ((IRGLView *)view).aspect = 1;
            //                [_player updateGraphicsViewFrame:view.frame];
            [((IRGLView *)view) updateViewPort:1.0];
            
            return view;
        }];
        
        [self addSubnode:_videoPlayerNode];
        
        _titleNode = [[ASTextNode alloc] init];
        _titleNode.attributedText = [[NSAttributedString alloc] initWithString:_videoModel.title attributes:[self titleNodeStringOptions]];
        _titleNode.style.flexGrow = 1.0;
        [self addSubnode:_titleNode];
        
        _avatarNode = [[ASNetworkImageNode alloc] init];
        _avatarNode.URL = _videoModel.avatarUrl;
        
        [_avatarNode setImageModificationBlock:^UIImage *(UIImage *image, ASPrimitiveTraitCollection traitCollection) {
            CGSize profileImageSize = CGSizeMake(AVATAR_IMAGE_HEIGHT * 3, AVATAR_IMAGE_HEIGHT);
            return [image makeCircularImageWithSize:profileImageSize];
        }];
        
        [self addSubnode:_avatarNode];
        
        _likeButtonNode = [[ASTextNode alloc] init];
        _likeButtonNode.attributedText = [[NSAttributedString alloc] initWithString:_videoModel.url.absoluteString attributes:[self titleNodeStringOptions]];
        _likeButtonNode.style.flexGrow = 1.0;
        _likeButtonNode.backgroundColor = [UIColor redColor];
        [self addSubnode:_likeButtonNode];
    }
    return self;
}

- (NSDictionary*)titleNodeStringOptions {
    return @{
        NSFontAttributeName : [UIFont systemFontOfSize:14.0],
        NSForegroundColorAttributeName: [UIColor labelColor]
    };
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    CGFloat fullWidth = [UIScreen mainScreen].bounds.size.width;
    
    _videoPlayerNode.style.width = ASDimensionMakeWithPoints(fullWidth);
    _videoPlayerNode.style.height = ASDimensionMakeWithPoints(fullWidth * 9 / 16);
    
    _avatarNode.style.width = ASDimensionMakeWithPoints(AVATAR_IMAGE_HEIGHT * 3);
    _avatarNode.style.height = ASDimensionMakeWithPoints(AVATAR_IMAGE_HEIGHT);
    
    _likeButtonNode.style.width = ASDimensionMakeWithPoints(50.0);
    _likeButtonNode.style.height = ASDimensionMakeWithPoints(26.0);
    
    ASStackLayoutSpec *headerStack  = [ASStackLayoutSpec horizontalStackLayoutSpec];
    headerStack.spacing = HORIZONTAL_BUFFER;
    headerStack.alignItems = ASStackLayoutAlignItemsCenter;
    [headerStack setChildren:@[ _avatarNode, _titleNode]];
    
    UIEdgeInsets headerInsets      = UIEdgeInsetsMake(HORIZONTAL_BUFFER, HORIZONTAL_BUFFER, HORIZONTAL_BUFFER, HORIZONTAL_BUFFER);
    ASInsetLayoutSpec *headerInset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:headerInsets child:headerStack];
    
    ASStackLayoutSpec *bottomControlsStack  = [ASStackLayoutSpec horizontalStackLayoutSpec];
    bottomControlsStack.spacing = HORIZONTAL_BUFFER;
    bottomControlsStack.alignItems = ASStackLayoutAlignItemsCenter;
    bottomControlsStack.children = @[_likeButtonNode];
    
    UIEdgeInsets bottomControlsInsets = UIEdgeInsetsMake(HORIZONTAL_BUFFER, HORIZONTAL_BUFFER, HORIZONTAL_BUFFER, HORIZONTAL_BUFFER);
    ASInsetLayoutSpec *bottomControlsInset  = [ASInsetLayoutSpec insetLayoutSpecWithInsets:bottomControlsInsets child:bottomControlsStack];
    
    
    ASStackLayoutSpec *verticalStack = [ASStackLayoutSpec verticalStackLayoutSpec];
    verticalStack.alignItems = ASStackLayoutAlignItemsStretch;
    verticalStack.children = @[headerInset, _videoPlayerNode, bottomControlsInset];
    return verticalStack;
}

@end
