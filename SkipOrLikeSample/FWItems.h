//
//  FWItems.h
//  Wishfeed_α
//
//  Created by Fumitaka Watanabe on 2014/05/21.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWItems : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) NSString *price;

- (instancetype)initWithName:(NSString *)name
                       image:(UIImage *)image
                         price:(NSString *)price;

@end
