//
//  BDMovieCell.m
//  BDCarService
//
//  Created by hu on 15/5/18.
//
//

#import "BDMovieCell.h"

@implementation BDMovieCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.layer.borderColor = kRGB(231, 231, 231).CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kFont(14);
        [self addSubview:_nameLabel];
        
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.backgroundColor = [UIColor orangeColor];
        _scoreLabel.textColor = [UIColor whiteColor];
        _scoreLabel.font = kFont(14);
        _scoreLabel.layer.cornerRadius = 5;
        _scoreLabel.layer.masksToBounds = YES;
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_scoreLabel];
        
        _tagView = [[BDTagView alloc] init];
        [self addSubview:_tagView];
    }
    
    return self;
}

@end
