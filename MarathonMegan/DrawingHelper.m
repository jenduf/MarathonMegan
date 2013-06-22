//
//  DrawingHelper.m
//  Trivie
//
//  Created by Jennifer Duffey on 3/20/12.
//  Copyright (c) 2012 Trivie. All rights reserved.
//

#import "DrawingHelper.h"

CGRect rectFor1PxStroke(CGRect rect)
{
	return CGRectMake(rect.origin.x + 0.5, rect.origin.y + 0.5, rect.size.width - 1, rect.size.height - 1);
}

CGRect getApplicationFrame()
{
	return [[UIScreen mainScreen] applicationFrame];
}

CGSize getContentSize()
{
	return CGSizeMake([[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height);
}

CGSize getAdjustedScale(float width, float height)
{
	const CGFloat scale = [UIScreen mainScreen].scale;
	
	return CGSizeMake(width * scale, height * scale);
}

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef  endColor)
{
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGFloat locations[] = { 0.0, 1.0 };
	
	NSArray *colors = [NSArray arrayWithObjects:(__bridge id)startColor, (__bridge id)endColor, nil];
	
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
	
	CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
	CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
	
	CGContextSaveGState(context);
	CGContextAddRect(context, rect);
	CGContextClip(context);
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	CGContextRestoreGState(context);
	
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorSpace);
}

void drawRadialGradient(CGContextRef context, CGRect rect, CGPoint startCenter, CGPoint endCenter, CGFloat startRadius, CGFloat endRadius, CGColorRef startColor, CGColorRef  endColor)
{
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGFloat locations[] = { 0.0, 1.0 };
	
	NSArray *colors = [NSArray arrayWithObjects:(__bridge id)startColor, (__bridge id)endColor, nil];
	
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
	
	CGContextSaveGState(context);
	CGContextAddRect(context, rect);
	CGContextClip(context);
	CGContextDrawRadialGradient(context, gradient, startCenter, startRadius, endCenter, endRadius, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
	CGContextRestoreGState(context);
	
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorSpace);
}

void drawStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color, CGFloat lineWidth)
{
	
	CGContextSaveGState(context);
	CGContextSetLineCap(context, kCGLineCapRound);
	CGContextSetStrokeColorWithColor(context, color);
	CGContextSetLineWidth(context, lineWidth);
	CGContextMoveToPoint(context, startPoint.x + 0.5, startPoint.y + 0.5);
	CGContextAddLineToPoint(context, endPoint.x + 0.5, endPoint.y + 0.5);
	CGContextStrokePath(context);
	CGContextRestoreGState(context);
	
}

void drawGlossAndGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor)
{
	
	drawLinearGradient(context, rect, startColor, endColor);
	
	CGColorRef glossColor1 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.35].CGColor;
	CGColorRef glossColor2 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1].CGColor;
	
	CGRect topHalf = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height/2);
	
	drawLinearGradient(context, topHalf, glossColor1, glossColor2);
	
}

CGMutablePathRef createRoundedRectForRect(CGRect rect, CGFloat radius)
{
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect));
	CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMaxY(rect), radius);
	CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), radius);
	CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMinY(rect), radius);
	CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMinY(rect), radius);
	CGPathCloseSubpath(path);
	
	return path;
}

// Draw centered text into the context
void centerText(CGContextRef context, NSString *fontname, float textsize, NSString *text, CGPoint point, UIColor *color)
{
	CGContextSaveGState(context);
	CGContextSelectFont(context, [fontname UTF8String], textsize, kCGEncodingMacRoman);
	
	// Retrieve the text width without actually drawing anything
	CGContextSaveGState(context);
	CGContextSetTextDrawingMode(context, kCGTextInvisible);
	CGContextShowTextAtPoint(context, 0.0f, 0.0f, [text UTF8String], text.length);
	CGPoint endpoint = CGContextGetTextPosition(context);
	CGContextRestoreGState(context);
	
	// Query for size to recover height. Width is less reliable
	CGSize stringSize = [text sizeWithFont:[UIFont fontWithName:fontname size:textsize]];
	
	// Draw the text
	[color setFill];
	CGContextSetShouldAntialias(context, true);
	CGContextSetTextDrawingMode(context, kCGTextFill);
	CGContextSetTextMatrix (context, CGAffineTransformMake(1, 0, 0, -1, 0, 0));
	CGContextShowTextAtPoint(context, point.x - endpoint.x / 2.0f, point.y + stringSize.height / 4.0f, [text UTF8String], text.length);
	CGContextRestoreGState(context);
}

#pragma mark -
#pragma mark General Purpose Methods


///////////////////////////////////////////////////////////////////////////////////////////////////
CGFloat boundf(CGFloat value, CGFloat min, CGFloat max)
{
	if (max < min)
	{
		max = min;
	}
	
	CGFloat bounded = value;
	if (bounded > max)
	{
		bounded = max;
	}
	
	if (bounded < min)
	{
		bounded = min;
	}
	
	return bounded;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
NSInteger boundi(NSInteger value, NSInteger min, NSInteger max)
{
	if (max < min)
	{
		max = min;
	}
	
	NSInteger bounded = value;
	if (bounded > max)
	{
		bounded = max;
	}
	
	if (bounded < min)
	{
		bounded = min;
	}
	
	return bounded;
}
