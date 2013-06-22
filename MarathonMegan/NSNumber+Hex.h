//
//  NSNumber+Hex.h
//  UsefulBits
//
//  Created by Kevin O'Neill on 9/12/11.
//  Copyright (c) 2011 Trivie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Hex)

+ (NSNumber *)integerWithHexString:(NSString *)hexString;

@end
