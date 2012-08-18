//
//  CandyTableViewController.h
//  CandySearch
//
//  Created by Erwin Mombay on 8/15/12.
//  Copyright (c) 2012 win. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDITorTableViewController:
UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) NSArray *nodeArray;
@property (nonatomic, strong) NSMutableArray *filteredNodeArray;

@end