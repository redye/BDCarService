//
//  BDDrawList.h
//  BDCarService
//
//  Created by hu on 15/5/10.
//
//

#import <UIKit/UIKit.h>

@interface BDDrawListView : UIView

@property (nonatomic, strong) NSDictionary *dataDictionary;
@property (nonatomic, strong) NSDictionary *secDictionary;
@property (nonatomic, strong) NSString     *keyItem;

- (void)reload;
- (void)setShowDrawView:(BOOL)b;

@end
