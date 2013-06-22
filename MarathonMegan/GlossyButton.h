//
//  GlossyButton.h
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/23/13.
//
//

#import <UIKit/UIKit.h>

@interface GlossyButton : UIButton

@property (nonatomic, strong) UIColor *buttonBackgroundColor, *buttonTextColor;
@property (nonatomic, assign) MarathonMeganColor meganColor;

- (id)initWithBackgroundColor:(UIColor *)backgroundColor andTextColor:(UIColor *)textColor;

@end
