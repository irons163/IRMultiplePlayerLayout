//
//  PlayerViewTableViewCell.m
//  IRMultiplePlayerLayout
//
//  Created by Phil on 2020/8/27.
//  Copyright © 2020 Phil. All rights reserved.
//

#import "PlayerViewTableViewCell.h"
#import <IRPlayer/IRPlayer.h>

@interface PlayerViewTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *playerView;

@end

@implementation PlayerViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _player = [IRPlayerImp player];
    [self.playerView addSubview:_player.view];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.playerView layoutIfNeeded];
    [_player updateGraphicsViewFrame:self.frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
