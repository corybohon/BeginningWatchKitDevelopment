//
//  DetailController.h
//  Top10
//
//  Created by Cory Bohon on 12/11/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import "JSONItem.h"

@interface DetailController : WKInterfaceController

@property (nonatomic, weak) IBOutlet WKInterfaceLabel *songTitleLabel;
@property (nonatomic, weak) IBOutlet WKInterfaceMovie *audioPreviewMovie;

@end
