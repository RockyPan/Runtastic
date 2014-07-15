//
//  RTLocationViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-6-19.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTLocationViewController : UITableViewController

@property (nonatomic, weak) id delegate;

//PK 以下信息由上层navigation item 传入
@property (nonatomic, copy) NSString * entityName;    //对应的实体名
@property (nonatomic, copy) NSString * attributeName; //对应属性名
@property (nonatomic, copy) NSString * caption;       //显示名字
@property (nonatomic, copy) NSString * setKey;        //回设值对象的key

- (IBAction)addNew:(id)sender;
- (IBAction)done:(id)sender;

@end
