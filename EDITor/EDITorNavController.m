//
//  EDITorNavController.m
//  EDITor
//
//  Created by Erwin Mombay on 8/19/12.
//  Copyright (c) 2012 win. All rights reserved.
//

#import "EDITorNavController.h"
#import "EDITorTableViewController.h"

#define bgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define localUrl [NSURL URLWithString:@"http://localhost:5000/document"]

@interface EDITorNavController()

@property (nonatomic, strong) EDITorTreeWalker *visitor;

@end

@implementation EDITorNavController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    self.visitor = [EDITorTreeWalker sharedManager];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}

#pragma mark - JSON Handler
- (void)fetchData:(NSData *)responseData {
    NSError *error;
    @try {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData
                                                             options:kNilOptions
                                                               error:&error];
        self.node = [EDINode createEDINodeFromDictionary:json withKey:@"TS_810"];
        [self reloadVisibleTableViewChild];
    } @catch (NSException *exception) {
        NSLog(@"Error(fetchData): %@ Exception: %@", error, exception);
    }
}
    
- (void)reloadVisibleTableViewChild {
    EDITorTableViewController *visibleChildTable = (EDITorTableViewController *)self.visibleViewController;
    visibleChildTable.nodes = self.node.collection;
    [visibleChildTable.tableView reloadData];
}

@end