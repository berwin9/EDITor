//
//  CandyTableViewController.m
//  CandySearch
//
//  Created by Erwin Mombay on 8/15/12.
//  Copyright (c) 2012 win. All rights reserved.
//

#define bgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define localUrl [NSURL URLWithString:@"http://localhost:5000/document"]

#import "EDITorTableViewController.h"
#import "EDINode.h"

@interface EDITorTableViewController()

@end

@implementation EDITorTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(bgQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:localUrl];
        [self performSelectorOnMainThread:@selector(fetchData:)
                               withObject:data
                            waitUntilDone:YES];
    });
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

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.nodeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"protoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    EDINode *node = nil;
    node = [self.nodeArray objectAtIndex:indexPath.row];
    cell.textLabel.text = node.label;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

#pragma mark - JSON Handler
- (void)fetchData:(NSData *)responseData {
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:&error];
    NSDictionary *tables = [json valueForKeyPath:@"TS_810.collection"];
    self.nodeArray = [EDINode createTsetEDINodeWithDictionary:tables];
    [self.tableView reloadData];
}

//#pragma mark - TableView Delegate
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self performSegueWithIdentifier:@"candyDetail" sender:tableView];
//}

//#pragma mark - Segue
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"candyDetail"]) {
//        UIViewController *candyDetailViewController = [segue destinationViewController];
//        NSIndexPath *indexPath = nil;
//        NSString *destinationTitle = nil;
//        if (sender == self.searchDisplayController.searchResultsTableView) {
//            indexPath = [self.searchDisplayController.searchResultsTableView
//                         indexPathForSelectedRow];
//            destinationTitle = [[self.filteredNodeArray objectAtIndex:[indexPath row]] name];
//        } else {
//            indexPath = [self.tableView indexPathForSelectedRow];
//            destinationTitle = [[self.nodeArray objectAtIndex:[indexPath row]] name];
//        }
//        [candyDetailViewController setTitle:destinationTitle];
//    }
//}

@end