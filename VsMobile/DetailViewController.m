//
//  DetailViewController.m
//  VsMobile
//
//  Created by admin on 7/10/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    NSString *msg = @"<html><center><font color='blue'>There is no content</font></center></html>";
    
    if (self.detailItem) {
        // Objective-C interprets the string <null> as a NSNull object. Exception is throw when it is used in a method
        if ([[self.detailItem objectForKey:@"HtmlContent"] isKindOfClass:[NSNull class]]) {
            [self.content loadHTMLString:msg baseURL:nil];
        }
        else {
            [self.content loadHTMLString:[self.detailItem objectForKey:@"HtmlContent"] baseURL:nil];
        }
        
        if ([[self.detailItem objectForKey:@"Name"] isKindOfClass:[NSNull class]]) {
            self.navigationItem.title = @"No Name property";
        }
        else {
            self.navigationItem.title = [self.detailItem objectForKey:@"Name"];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
