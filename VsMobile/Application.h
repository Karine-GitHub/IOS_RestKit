//
//  Application.h
//  VsMobile
//
//  Created by admin on 7/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Page.h"

@interface Application : NSDictionary

@property (nonatomic, strong) NSString *copyright;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *support;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *guidID;

@property (nonatomic, strong) NSMutableArray *pagesList;

@property (nonatomic) Page *allPages;

-(NSMutableDictionary *)setApplication;

@end
