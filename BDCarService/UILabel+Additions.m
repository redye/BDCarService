//
//  UILabel+Additions.m
//  BDCarService
//
//  Created by hu on 15/5/12.
//
//

#import "UILabel+Additions.h"

@implementation UILabel (Additions)

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text font:(NSInteger)size
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.text = text;
        if (text.length == 0 || !text)
        {
            self.text = @"Null";
            self.textColor = [UIColor grayColor];
        }
        
        self.font = kFont(size);
    }
    
    return self;
}

@end
