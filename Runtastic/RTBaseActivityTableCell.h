//
//  RTBaseActivityTableCell.h
//  Runtastic
//
//  Created by PanKyle on 14-6-11.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTBaseActivityTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLable;
@property (weak, nonatomic) IBOutlet UILabel *durationLable;

@end
