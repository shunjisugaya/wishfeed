//
//  FWItems.m
//  Wishfeed_α
//
//  Created by Fumitaka Watanabe on 2014/05/21.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//

#import "FWItems.h"

@implementation FWItems


#pragma mark - Object Lifecycle

- (instancetype)initWithName:(NSString *)name
                       image:(UIImage *)image
                         price:(NSString *)price {
    self = [super init];
    if (self) {
        _name = name;
        _image = image;
        _price = price;
       
    }
    return self;
}


@end
