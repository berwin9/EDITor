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

@synthesize nodeArray = _nodeArray;
@synthesize filteredNodeArray = _filteredNodeArray;
@synthesize nodeSearchBar = _nodeSearchBar;

-(id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(bgQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:localUrl];
        [self performSelectorOnMainThread:@selector(fetchData:)
                               withObject:data
                            waitUntilDone:YES];
    });
    [self.nodeSearchBar setShowsScopeBar:NO];
    [self.nodeSearchBar sizeToFit];
    CGRect newBounds = self.tableView.bounds;
    newBounds.origin.y = newBounds.origin.y + self.nodeSearchBar.bounds.size.height;
    self.tableView.bounds = newBounds;

}

-(void)fetchData:(NSData *)responseData {
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:&error];
    NSDictionary *tables = [json valueForKeyPath:@"TS_810.collection"];
    NSArray *sortedKeys = [tables keysSortedByValueUsingComparator:^(id obj1, id obj2) {
        static NSString *sep = @"_", *keyToComp = @"fullName";
        NSString *name1= [[[obj1 objectForKey:keyToComp] componentsSeparatedByString:sep] lastObject];
        NSString *name2 = [[[obj2 objectForKey:keyToComp] componentsSeparatedByString:sep] lastObject];
        return [name1 caseInsensitiveCompare:name2];
    }];
    int ctr = 0;
    NSMutableArray *models = [[NSMutableArray alloc] init];
    for (id key in tables) {
        NSDictionary *child = [tables objectForKey:[sortedKeys objectAtIndex:ctr]];
        [models addObject:[[EDINode alloc] initWithLabel:[child objectForKey:@"name"]
                                                 ediName:[child objectForKey:@"fullName"]
                                                nodeType:@"s"
                                              collection:[child objectForKey:@"collection"]]];
        ctr++;
    }
    self.nodeArray = [NSArray arrayWithArray:models];
    self.filteredNodeArray = [NSMutableArray arrayWithCapacity:[self.nodeArray count]];
    [self.tableView reloadData];
}

-(void)viewDidUnload {
    [super viewDidUnload];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)goToSearch:(id)sender {
    [self.nodeSearchBar becomeFirstResponder];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredNodeArray count];
    }
    return [self.nodeArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"protoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    EDINode *node = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        node = [self.filteredNodeArray objectAtIndex:indexPath.row];
    } else {
        node = [self.nodeArray objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = node.label;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

#pragma mark - Content Filtering
-(void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope {
    [self.filteredNodeArray removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@", searchText];
    NSArray *tempArray = [self.nodeArray filteredArrayUsingPredicate:predicate];
    if (![scope isEqualToString:@"Header"]) {
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.category contains[c] %@", scope];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    self.filteredNodeArray = [NSMutableArray arrayWithArray:tempArray];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchScope:(NSInteger)searchOption {
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text
                               scope:[[self.searchDisplayController.searchBar
                                       scopeButtonTitles] objectAtIndex:searchOption]];
    return YES;
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