//
//  BDWayCell.h
//  BDCarService
//
//  Created by hu on 15/5/22.
//
//

#import <UIKit/UIKit.h>

@interface BDWayCell : UITableViewCell

@property (nonatomic, strong) UILabel   *nameLabel;
@property (nonatomic, strong) UILabel   *addressLabel;
@property (nonatomic, strong) UILabel   *locaionLabel;
@property (nonatomic, strong) UILabel   *speedLabel;
@property (nonatomic, strong) UIWebView *webView;

@end
