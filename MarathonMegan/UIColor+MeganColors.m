//
//  UIColor+MeganColors.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 3/8/13.
//
//

#import "UIColor+MeganColors.h"

@implementation UIColor (MeganColors)

+ (UIColor *)colorForMeganColor:(MarathonMeganColor)color
{
	switch (color)
	{
		case MarathonMeganColorYellow:
			return [UIColor yellowColor];
			break;
			
		case MarathonMeganColorOrange:
			return [UIColor orangeColor];
			break;
			
		case MarathonMeganColorBlue:
			return [UIColor blueColor];
			break;
			
		case MarathonMeganColorGreen:
			return [UIColor greenColor];
			break;
			
		case MarathonMeganColorRed:
			return [UIColor redColor];
			break;
			
		case MarathonMeganColorVine:
			return [UIColor colorWithHexString:VINE_COLOR];
			break;
			
		default:
			break;
	}
}

@end
