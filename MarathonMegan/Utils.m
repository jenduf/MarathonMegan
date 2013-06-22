//
//  Utils.m
//  Trivie
//
//  Created by Jennifer Duffey on 2/10/12.
//  Copyright (c) 2012 Trivie. All rights reserved.
//


@implementation Utils

+ (NSString *)dateStringForDate:(NSDate *)date withStyle:(NSDateFormatterStyle)style
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:style];
	return [formatter stringFromDate:date];
}

+ (BOOL) isRetina
{
	return ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2);
}

+ (BOOL) isFourInchScreen
{
	return (IS_TALLSCREEN && [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone);
}

+(CGFloat)appHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+(CGFloat)appWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (void)logAllFontNames
{
	for(NSString *str in [UIFont familyNames])
	{
		NSLog(@"%@", str);
	}
	
	NSLog(@"Font names: %@", [UIFont fontNamesForFamilyName:@"Bauhaus 93"]);
}

+ (NSString *)removeWhitespaceFromString:(NSString *)string
{
	return [[string componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString: @""];
}

@end
