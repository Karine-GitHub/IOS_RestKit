//
//  Page.m
//  VsMobile
//
//  Created by admin on 7/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "Page.h"

@implementation Page

-(NSMutableDictionary *)setPage:(NSMutableArray *) allPages :(NSIndexPath *) index{
    NSMutableDictionary *myPage = allPages[index.row];
    
    return myPage;
}

@end
