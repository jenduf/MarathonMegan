//
//  UIFont+MegansFont.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/23/13.
//
//

#import "UIFont+MegansFont.h"

@implementation UIFont (MegansFont)

+ (UIFont *)marketingFontOfSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:FONT_MARKETING_SCRIPT size:fontSize];
}

+ (UIFont *)funFontOfSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:FONT_BAUHAUS size:fontSize];
}

@end
