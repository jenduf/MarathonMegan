//
//  Utils.h
//  Trivie
//
//  Created by Jennifer Duffey on 2/10/12.
//  Copyright (c) 2012 Trivie. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Utils : NSObject

+ (NSString *)dateStringForDate:(NSDate *)date withStyle:(NSDateFormatterStyle)style;
+ (BOOL) isRetina;
+ (BOOL) isFourInchScreen;
+ (CGFloat)appHeight;
+ (CGFloat)appWidth;
+ (void)logAllFontNames;
+ (NSString *)removeWhitespaceFromString:(NSString *)string;

@end
