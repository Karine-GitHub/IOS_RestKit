//
//  MasterViewController.m
//  VsMobile
//
//  Created by admin on 7/10/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"


@interface MasterViewController () {
    Application *app;
    Page *allPages;
    NSDictionary *page;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)configureRestKit
{
    if (!app) {
        app = [[Application alloc]init];
    }
    if (!allPages) {
        allPages = [[Page alloc] init];
    }
    
    // Initialize connection to WebApi
    NSURL *webApi = [NSURL URLWithString:@"http://localhost:1130/api"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:webApi];
    
    // Interface for interacting with services of RestKit framework
    RKObjectManager *objManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // Set application mapping
    RKObjectMapping *applicationMapping = [RKObjectMapping mappingForClass:[Application class]];
    [applicationMapping addAttributeMappingsFromDictionary:[app setApplication]];
    
    // Set pages mapping
    RKObjectMapping *pagesMapping = [RKObjectMapping mappingForClass:[Page class]];
    [pagesMapping addAttributeMappingsFromArray:[allPages getAllPages:[[app setApplication] objectForKey:@"Pages"]]];
    
    // define relationship between Application et Pages
    [applicationMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"Pages" toKeyPath:@"Pages" withMapping:pagesMapping]];
    
    // Get json file & map Application object
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:applicationMapping method:RKRequestMethodGET pathPattern:@"/application" keyPath:@"response.application" statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objManager addResponseDescriptor:responseDescriptor];
}

- (void)loadApplication
{
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/application" parameters:[[app setApplication] objectForKey:@"Id"] success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        app = mappingResult.dictionary;
        
        // Objective-C interprets the string <null> as a NSNull object. Exception is throw when it is used in a method
        if ([[app objectForKey:@"Pages"] isKindOfClass:[NSNull class]]) {
            allPages = nil;
        } else {
            allPages = [app objectForKey:@"Pages"];
        }

        [self.tableView reloadData];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"An error occurred': %@", error);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    [self configureRestKit];
    [self loadApplication];
    [self insertNewObject];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject
{
    for (NSInteger nbpage=0; nbpage<((allPages.count)); ++nbpage) {
        NSLog(@"%d", nbpage);
        
        NSIndexPath *indexPathTable = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPathTable] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allPages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    page = allPages[indexPath.row];
    
    if ([[page objectForKey:@"Name"] isKindOfClass:[NSNull class]]) {
        cell.textLabel.text = @"No Name property";
    } else {
        cell.textLabel.text = [[page objectForKey:@"Name"] description];
    }

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [allPages removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        page = allPages[indexPath.row];
        self.detailViewController.detailItem = page;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        page = allPages[indexPath.row];
        [[segue destinationViewController] setDetailItem:page];
    }
}

@end
