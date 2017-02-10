//
//  ComplicationController.m
//  Top10 WatchKit App Extension
//
//  Created by Cory Bohon on 12/5/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import "ComplicationController.h"

@interface ComplicationController ()

@property (nonatomic, strong) NSArray *timelineEntries;

@end

@implementation ComplicationController

- (id)init
{
    if (self = [super init]) {
        self.timelineEntries = @[@"Never Gonna Give You Up by Rick Astly", @"Unlock My iPhone by FBI", @"The Screen Door Song by Kyle Richter"];
    }
    return self;
}

- (void)requestedUpdateDidBegin
{
    
}

#pragma mark - Timeline Configuration 
- (void)getSupportedTimeTravelDirectionsForComplication:(CLKComplication *)complication withHandler:(void (^)(CLKComplicationTimeTravelDirections))handler
{
    handler(CLKComplicationTimeTravelDirectionForward);
}

- (void)getTimelineStartDateForComplication:(CLKComplication *)complication withHandler:(void (^)(NSDate * _Nullable))handler
{
    handler([NSDate date]);
}

- (void)getTimelineEndDateForComplication:(CLKComplication *)complication withHandler:(void (^)(NSDate * _Nullable))handler
{
    handler([[NSDate date] dateByAddingTimeInterval:6 * 60 * 60]);
}

- (void)getPrivacyBehaviorForComplication:(CLKComplication *)complication withHandler:(void (^)(CLKComplicationPrivacyBehavior))handler
{
    handler(CLKComplicationPrivacyBehaviorShowOnLockScreen);
}

#pragma mark - Timeline Population
- (void)getCurrentTimelineEntryForComplication:(CLKComplication *)complication withHandler:(void (^)(CLKComplicationTimelineEntry * _Nullable))handler
{
    if (complication.family == CLKComplicationFamilyModularLarge) {
        CLKComplicationTimelineEntry *entry = [self createModularLargeTimelineEntryWithHeaderText:@"Top 10" bodyText:[self.timelineEntries firstObject] andDate:[NSDate date]];
        handler(entry);
    }
    
    if (complication.family == CLKComplicationFamilyUtilitarianLarge) {
        CLKComplicationTimelineEntry *entry = [self createUtilitarianLargeTimelineEntryWithHeaderText:@"Top 10" bodyText:[self.timelineEntries firstObject] andDate:[NSDate date]];
        handler(entry);
    }
}

- (void)getTimelineEntriesForComplication:(CLKComplication *)complication afterDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void (^)(NSArray<CLKComplicationTimelineEntry *> * _Nullable))handler
{
    if (complication.family != CLKComplicationFamilyModularLarge ||
        complication.family != CLKComplicationFamilyUtilitarianLarge) {
        handler(nil);
    }
    
    NSMutableArray *timelineEntries = [[NSMutableArray alloc] init];
    NSDate *dateOffset = [date dateByAddingTimeInterval:60 * 60 * 1];
    
    for (NSString *string in self.timelineEntries) {
        if (complication.family == CLKComplicationFamilyUtilitarianLarge) {
            [timelineEntries addObject:[self createUtilitarianLargeTimelineEntryWithHeaderText:@"Top 10" bodyText:string andDate:dateOffset]];
            dateOffset = [dateOffset dateByAddingTimeInterval:60 * 60 * 1];
        }
        
        if (complication.family == CLKComplicationFamilyModularLarge) {
            [timelineEntries addObject:[self createModularLargeTimelineEntryWithHeaderText:@"Top 10" bodyText:string andDate:dateOffset]];
            dateOffset = [dateOffset dateByAddingTimeInterval:60 * 60 * 1];
        }
    }
    
    handler(timelineEntries);
}

#pragma mark - Placeholder Templates 
- (void)getLocalizableSampleTemplateForComplication:(CLKComplication *)complication withHandler:(void (^)(CLKComplicationTemplate * _Nullable))handler
{
    if (complication.family != CLKComplicationFamilyModularLarge ||
        complication.family != CLKComplicationFamilyUtilitarianLarge) {
        handler(nil);
    }
    
    CLKComplicationTemplate *templateToReturn;
    
    if (complication.family == CLKComplicationFamilyModularLarge) {
        CLKComplicationTemplateModularLargeStandardBody *modularLarge = [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
        modularLarge.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:@"Top Song"];
        modularLarge.body1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"-"];
        modularLarge.body2TextProvider = [CLKSimpleTextProvider textProviderWithText:@""];
        templateToReturn = modularLarge;
    }
    
    if (complication.family == CLKComplicationFamilyUtilitarianLarge) {
        CLKComplicationTemplateUtilitarianLargeFlat *utilitarianLarge = [[CLKComplicationTemplateUtilitarianLargeFlat alloc] init];
        utilitarianLarge.textProvider = [CLKSimpleTextProvider textProviderWithText:@"Top Song: ---"];
        templateToReturn = utilitarianLarge;
    }
    
    handler(templateToReturn);
}

#pragma mark - Helper Methods 
- (CLKComplicationTimelineEntry *)createModularLargeTimelineEntryWithHeaderText:(NSString *)header bodyText:(NSString *)body andDate:(NSDate *)date
{
    CLKComplicationTemplateModularLargeStandardBody *modularLarge = [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
    
    modularLarge.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:@"Top Song"];
    
    modularLarge.body1TextProvider = [CLKSimpleTextProvider textProviderWithText:body];
    modularLarge.body2TextProvider = [CLKSimpleTextProvider textProviderWithText:@""];
    
    return [CLKComplicationTimelineEntry entryWithDate:date complicationTemplate:modularLarge];
}

- (CLKComplicationTimelineEntry *)createUtilitarianLargeTimelineEntryWithHeaderText:(NSString *)header bodyText:(NSString *)body andDate:(NSDate *)date
{
    CLKComplicationTemplateUtilitarianLargeFlat *utilitarianLarge = [[CLKComplicationTemplateUtilitarianLargeFlat alloc] init];
    utilitarianLarge.textProvider = [CLKSimpleTextProvider textProviderWithText:body];
    
    return [CLKComplicationTimelineEntry entryWithDate:date complicationTemplate:utilitarianLarge];
}

@end
