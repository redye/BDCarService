//
//  UtilsMacro.h
//  BDCarService
//
//  Created by hu on 15/5/10.
//
//

#ifndef BDCarService_UtilsMacro_h
#define BDCarService_UtilsMacro_h

#define kBOUNDS [[UIScreen mainScreen] bounds]

//已经选择一项菜单时
#define kBDMenuDidChangeNotification @"BDMenuDidChangeNotification"
#define kMenuItem @"menuItem"
#define kMenuType @"menuType"

//向右滑动根视图时
#define kBDRootViewControllerWillShowNotification @"BDRootViewControllerWillShowNotification"

#define kLocation @"location"

//定义内容表与最高点的距离
#define kTopPadding 164

#define kCellHeight 50

#define kFont(size) [UIFont systemFontOfSize:size]
#define kRGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define kRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//历史查询记录，值记载五个
#define kHistory @"history"

#endif
