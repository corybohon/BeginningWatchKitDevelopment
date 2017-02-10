//
//  DetailController.m
//  Top10
//
//  Created by Cory Bohon on 12/11/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import "DetailController.h"

@interface DetailController ()

@property (nonatomic, weak) IBOutlet WKInterfaceLabel *noteLabel;
@property (nonatomic, strong) JSONItem *item;

@end

@implementation DetailController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    
    JSONItem *detailItem = (JSONItem *)context;
    self.item = detailItem;
    
    [self.songTitleLabel setText:detailItem.songTitle];
    
    [self.audioPreviewMovie setMovieURL:detailItem.audioPreviewURL];
    [self.audioPreviewMovie setPosterImage:[WKImage imageWithImageData:[NSData dataWithContentsOfURL:detailItem.imageURL]]];
    [self.audioPreviewMovie setLoops:NO];
}

- (void)didAppear
{
    [self.noteLabel setText:[[NSUserDefaults standardUserDefaults] objectForKey:self.item.songTitle]];
}

#pragma mark - Notes Handling 
- (IBAction)addNoteButtonTapped:(id)sender
{
    NSMutableArray *suggestions = [[NSMutableArray alloc] init];
    [suggestions addObject:@"Love this song"];
    [suggestions addObject:@"This is a good song"];
    [suggestions addObject:@"Meh"];
    [suggestions addObject:@"Worst. Song. Evar."];
    
    [self presentTextInputControllerWithSuggestions:suggestions allowedInputMode:WKTextInputModeAllowEmoji completion:^(NSArray * _Nullable results) {
        if (!results.count) {
            // Nothing selected, return
            return;
        }
        
        NSString *input = [results firstObject];
        
        [self.noteLabel setText:input];
        
        [[NSUserDefaults standardUserDefaults] setObject:input forKey:self.item.songTitle];
    }];
}

@end
