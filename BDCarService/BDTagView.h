//
//  BDTagView.h
//  BDCarService
//
//  Created by hu on 15/5/18.
//
//

#import <UIKit/UIKit.h>

@interface BDTagView : UIView

- (instancetype)initWithFrame:(CGRect)frame tags:(NSArray *)tags;
- (CGSize)sizeOfStringWithFontSize:(NSInteger)fontSize;
- (void)addTagsWithArray:(NSArray *)tags;

@end
