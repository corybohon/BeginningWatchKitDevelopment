//
//  DetailViewController.h
//  Top10
//
//  Created by Cory Bohon on 12/5/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSONItem;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) JSONItem *detailItem;

@end

