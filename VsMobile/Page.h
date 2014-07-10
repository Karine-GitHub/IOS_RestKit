//
//  Page.h
//  VsMobile
//
//  Created by admin on 7/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Template.h"

@interface Page : NSObject

@property (nonatomic, strong) NSString *templateName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *externalUrl;
@property (nonatomic, strong) NSString *htmlContent;
@property (nonatomic, strong) NSString *guidID;

@property (nonatomic) Boolean *isExternal;

@property (nonatomic, strong) Template *template;

-(NSMutableDictionary *)setPage:(NSMutableArray *)allPages :(NSIndexPath *)index;

@end
