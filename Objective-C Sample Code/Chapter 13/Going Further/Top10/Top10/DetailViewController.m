//
//  DetailViewController.m
//  Top10
//
//  Created by Cory Bohon on 12/5/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import "DetailViewController.h"
#import "JSONItem.h"

@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UILabel *songTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *artistTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *releaseDateLabel;
@property (nonatomic, weak) IBOutlet UILabel *albumLabel;
@property (nonatomic, weak) IBOutlet UILabel *genreNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;

@end

@implementation DetailViewController

- (void)setDetailItem:(JSONItem *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
}

- (void)configureView
{
    if (self.detailItem) {
        self.title = self.detailItem.songTitle;
        self.songTitleLabel.text = self.detailItem.songTitle;
        self.artistTitleLabel.text = self.detailItem.artistName;
        self.releaseDateLabel.text = self.detailItem.releaseDate;
        self.albumLabel.text = self.detailItem.albumName;
        self.genreNameLabel.text = self.detailItem.genreTitle;
        
        self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", [self.detailItem.priceInUSD floatValue]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}


@end
