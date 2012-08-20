//
//  EDITorTableViewController.m
//  EDITor
//
//  Created by Erwin Mombay on 8/15/12.
//  Copyright (c) 2012 win. All rights reserved.
//

#define bgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define localUrl [NSURL URLWithString:@"http://localhost:5000/document"]

#import "EDITorTableViewController.h"
#import "EDITorTreeWalker.h"
#import "EDINode.h"

@interface EDITorTableViewController()

@property (nonatomic, strong) EDITorTreeWalker *visitor;
@property(nonatomic, assign) UIModalTransitionStyle style;

@end

@implementation EDITorTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        _style = UIModalTransitionStyleFlipHorizontal;
    }
    return self;
}

+ (EDITorTableViewController *)sharedMananger {
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(bgQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:localUrl];
        [self performSelectorOnMainThread:@selector(fetchData:)
                               withObject:data
                            waitUntilDone:YES];
    });
    self.visitor = [EDITorTreeWalker sharedManager];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.nodes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"protoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    static NSUInteger ctr = 0;
    EDINode *node = [self.nodes objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %d", node.label, ctr++];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

#pragma mark - JSON Handler
- (void)fetchData:(NSData *)responseData {
    NSError *error;
    //TODO: add error handling if json is empty
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:&error];
    
    NSDictionary *tables = [json valueForKeyPath:@"TS_810"];
    self.nodes = [EDINode createEDINodesFromDictionary:tables];
    [self.tableView reloadData];
}


#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController =
        [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:NULL]
            instantiateViewControllerWithIdentifier:@"Test"];
    static NSUInteger ctrl = 0;
    [viewController setTitle:[NSString stringWithFormat:@"stringy %d", ctrl++]];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end