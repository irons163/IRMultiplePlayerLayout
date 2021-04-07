//
//  TableViewLayoutViewController.m
//  IRMultiplePlayerLayout
//
//  Created by Phil on 2020/8/28.
//  Copyright © 2020 Phil. All rights reserved.
//

#import "TableViewLayoutViewController.h"
#import "PlayerViewTableViewCell.h"

@interface TableViewLayoutViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TableViewLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PlayerViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"PlayerViewTableViewCell"];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Demo";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayerViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerViewTableViewCell"];
    cell.player.decoder = [IRPlayerDecoder FFmpegDecoder];
    [cell.player replaceVideoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"i-see-fire" ofType:@"mp4"]]];
    [cell.player play];
    
    return cell;
}

@end
