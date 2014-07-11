//
//  MasterViewController.h
//  VsMobile
//
//  Created by admin on 7/10/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <RestKit/RestKit.h>
//#import <AFNetworking/AFNetworking.h>
//#import <RKValueTransformers/RKValueTransformers.h>

#import "Application.h"


@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
