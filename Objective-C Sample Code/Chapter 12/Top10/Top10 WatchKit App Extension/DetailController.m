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
@property (nonatomic, weak) IBOutlet WKInterfaceImage *emojiImage;
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
    
    [self invalidateUserActivity];
}

- (void)didAppear
{
    NSObject *input = [[NSUserDefaults standardUserDefaults] objectForKey:self.item.songTitle];
    
    if ([input isKindOfClass:[NSString class]]) {
        [self.noteLabel setText:(NSString *)input];
    } else if ([input isKindOfClass:[NSData class]]) {
        [self.emojiImage setImage:[UIImage imageWithData:(NSData *)input]];
    }
    
    [self updateUserActivity:@"com.Top10.viewing" userInfo:@{@"object" : self.item.songTitle} webpageURL:nil];
}

#pragma mark - Notes Handling
- (IBAction)addNoteButtonTapped:(id)sender
{
    NSMutableArray *suggestions = [[NSMutableArray alloc] init];
    [suggestions addObject:@"Love this song"];
    [suggestions addObject:@"This is a good song"];
    [suggestions addObject:@"Meh"];
    [suggestions addObject:@"Worst. Song. Evar."];
    
    [self presentTextInputControllerWithSuggestions:suggestions allowedInputMode:WKTextInputModeAllowAnimatedEmoji completion:^(NSArray * _Nullable results) {
        if (!results.count) {
            // Nothing selected, return
            return;
        }
        
        NSObject *input = [results firstObject];
        
        if ([input isKindOfClass:[NSString class]]) {
            [self.noteLabel setText:(NSString *)input];
            [self.emojiImage setImage:nil];
        } else if ([input isKindOfClass:[NSData class]]) {
            [self.emojiImage setImage:[UIImage imageWithData:(NSData *)input]];
            [self.noteLabel setText:nil];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:input forKey:self.item.songTitle];
    }];
}

@end
