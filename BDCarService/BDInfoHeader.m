//
//  BDInfoHeader.m
//  BDCarService
//
//  Created by hu on 15/5/19.
//
//

#import "BDInfoHeader.h"

@implementation BDInfoHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        _isExpand = YES;
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kBOUNDS.size.width, 20)];
        [self addSubview:_nameLabel];
        
        _teleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, kBOUNDS.size.width, 20)];
        [self addSubview:_teleLabel];
        
        _addresslabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kBOUNDS.size.width, 20)];
//        _addresslabel.numberOfLines = 0;
        [self addSubview:_addresslabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandSection)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)expandSection
{
    self.isExpand = !self.isExpand;
//    self.expandBlock(self.isExpand);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
