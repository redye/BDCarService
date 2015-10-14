//
//  BDTagView.m
//  BDCarService
//
//  Created by hu on 15/5/18.
//
//

#import "BDTagView.h"
#import "NSString+Additions.h"

#define kSPACE 10

@implementation BDTagView

- (instancetype)initWithFrame:(CGRect)frame tags:(NSArray *)tags
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGFloat width = 0;
        CGFloat totalWidth = 0;
        
        for (int i=0; i<tags.count; i++)
        {
            width = [tags[i] sizeOfString].width+10;
            UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(totalWidth, 5, width, frame.size.height-10)];
            tagLabel.backgroundColor = kRGB(123, 183, 255);
            tagLabel.text = tags[i];
            tagLabel.layer.cornerRadius = 5;
            tagLabel.layer.masksToBounds = YES;
            tagLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:tagLabel];
            totalWidth += (width+kSPACE);
            if (totalWidth > frame.size.width)
            {
                return self;
            }
        }
    }
    return self;
}

- (void)addTagsWithArray:(NSArray *)tags
{
    CGRect frame = self.frame;
    
    CGFloat width = 0;
    CGFloat totalWidth = 0;
    
    for (int i=0; i<tags.count; i++)
    {
        width = [tags[i] sizeOfStringWithFontSize:12].width+10;
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(totalWidth, 5, width, frame.size.height-10)];
        tagLabel.backgroundColor = kRGB(123, 183, 255);
        tagLabel.text = tags[i];
        tagLabel.font = kFont(12);
        tagLabel.layer.cornerRadius = 5;
        tagLabel.layer.masksToBounds = YES;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tagLabel];
        
        totalWidth += (width+kSPACE);
        if (totalWidth > frame.size.width)
        {
            return;
        }
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
