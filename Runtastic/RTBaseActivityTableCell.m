//
//  RTBaseActivityTableCell.m
//  Runtastic
//
//  Created by PanKyle on 14-6-11.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTBaseActivityTableCell.h"

@implementation RTBaseActivityTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
