//
//  PlaceholderTextView.h
//  拥有占位文字功能的TextView

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
