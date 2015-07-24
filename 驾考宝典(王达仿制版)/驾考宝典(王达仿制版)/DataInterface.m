//
//  DataInterface.m
//  ScrollViewDeom
//
//  Created by chencheng on 15/6/17.
//  Copyright (c) 2015年 chencheng. All rights reserved.
//

#import "DataInterface.h"

@implementation DataInterface
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.randomNumber =0;
        self.number =nil;
        self.subjectContent = nil;
        self.subjectImage = nil;
        self.alternatives = nil;
        self.answer = nil;
        self.explain = nil;
    }
    return self;
}
@end
