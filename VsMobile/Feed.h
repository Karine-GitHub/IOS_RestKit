//
//  Feed.h
//  VsMobile
//
//  Created by admin on 7/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feed : NSObject

@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *contentUri;
@property (nonatomic, strong) NSString *footerUri;
@property (nonatomic, strong) NSString *headerUri;
@property (nonatomic, strong) NSString *imageOverUri;
@property (nonatomic, strong) NSString *imageUri;
@property (nonatomic, strong) NSString *originalId;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;

@property (nonatomic, strong) NSString *guidID;
@property (nonatomic, strong) NSString *parentGuidID;

@property (nonatomic) NSInteger *cacheDuration;

@property Boolean *isActive;
@property Boolean *isFilter;
@property Boolean *isSearchable;
@property Boolean *needAuthentication;

@property (nonatomic, strong) NSDate *publishDate;


@end
