//
//  TextureTableViewViewController.m
//  IRMultiplePlayerLayout
//
//  Created by Phil on 2020/8/28.
//  Copyright © 2020 Phil. All rights reserved.
//

#import "TextureTableViewViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "VideoModel.h"
#import "VideoContentCell.h"

@interface TextureTableViewViewController ()<ASTableDelegate, ASTableDataSource>

@end

@implementation TextureTableViewViewController
{
  ASTableNode *_tableNode;
  NSMutableArray<VideoModel*> *_videoFeedData;
}

- (instancetype)init
{
  _tableNode = [[ASTableNode alloc] init];
  _tableNode.delegate = self;
  _tableNode.dataSource = self;

  if (!(self = [super initWithNode:_tableNode])) {
    return nil;
  }
  
  [self generateFeedData];
  self.navigationItem.title = @"Home";

  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [_tableNode reloadData];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
  return UIStatusBarStyleLightContent;
}

- (void)generateFeedData
{
  _videoFeedData = [[NSMutableArray alloc] init];

  for (int i = 0; i < 12; i++) {
    [_videoFeedData addObject:[[VideoModel alloc] init]];
  }
}

#pragma mark - ASCollectionDelegate - ASCollectionDataSource

- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode
{
  return 1;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section
{
  return _videoFeedData.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath {
  VideoModel *videoObject = [_videoFeedData objectAtIndex:indexPath.row];
  return ^{
    VideoContentCell *cellNode = [[VideoContentCell alloc] initWithVideoObject:videoObject];
    return cellNode;
  };
}

@end

