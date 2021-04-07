//
//  PlayerViewTableViewCell.h
//  IRMultiplePlayerLayout
//
//  Created by Phil on 2020/8/27.
//  Copyright © 2020 Phil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IRPlayer/IRPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayerViewTableViewCell : UITableViewCell

@property (readonly) IRPlayerImp *player;

@end

NS_ASSUME_NONNULL_END
