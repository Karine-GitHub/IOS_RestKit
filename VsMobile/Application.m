//
//  Application.m
//  VsMobile
//
//  Created by admin on 7/10/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "Application.h"

@implementation Application

-(NSDictionary *)setApplication {
    NSDictionary *myApplication = @{@"Pages": self.allPages,
                                           @"Id": self.guidID,
                                           @"Name": self.name,
                                           @"Description": self.description,
                                           @"Copyright": self.copyright,
                                           @"Support": self.support,
                                           @"Url": self.url};
    return myApplication;
}


@end
