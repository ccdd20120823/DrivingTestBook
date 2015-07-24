//
//  DataInterface.h
//  ScrollViewDeom
//
//  Created by chencheng on 15/6/17.
//  Copyright (c) 2015年 chencheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataInterface : NSObject
@property (assign,nonatomic)int randomNumber;
@property (copy,nonatomic)NSString *number;
@property (strong,nonatomic) NSString *subjectContent;
@property (strong,nonatomic) NSString *subjectImage;
@property (strong,nonatomic) NSArray *alternatives;
@property (strong,nonatomic) NSString *answer;
@property (strong,nonatomic) NSString *explain;
@end
