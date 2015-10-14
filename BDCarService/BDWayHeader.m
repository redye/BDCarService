//
//  BDWayHeader.m
//  BDCarService
//
//  Created by hu on 15/5/23.
//
//

#import "BDWayHeader.h"

@implementation BDWayHeader

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.isSelected = !self.isSelected;
    self.selectedBlock(self.isSelected);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
