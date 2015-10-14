//
//  BDMovieCell.h
//  BDCarService
//
//  Created by hu on 15/5/18.
//
//

#import <UIKit/UIKit.h>
#import "BDTagView.h"
#import "BDMMovieModels.h"

@interface BDMovieCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *scoreLabel;
@property (nonatomic, strong) BDTagView   *tagView;

//- (void)reloadViewsWithMovie:(BDMMovie *)movie;

@end
