//
//  ComplicationController.swift
//  Top10
//
//  Created by Cory Bohon on 2/14/17.
//  Copyright © 2017 Cory Bohon. All rights reserved.
//

import UIKit
import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    let timelineEntries: Array<String> = ["Never Gonna Give You Up by Rick Astly", "Unlock My iPhone by FBI", "The Screen door Song by Kyle Richter"]
    
    func requestedUpdateDidBegin() {
        
    }

    // MARK: - Timeline Configuration 
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        
        handler(.forward)
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(Date())
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(Date().addingTimeInterval(6 * 60 * 60))
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population 
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        
        if complication.family == .modularLarge {
            let entry: CLKComplicationTimelineEntry = self.createTimelineEntry(headerText: "Top 10", bodyText: self.timelineEntries.first!, date: Date())
            handler(entry)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        if complication.family != .modularLarge {
            handler(nil)
        }
        
        var timelineEntries: Array<CLKComplicationTimelineEntry> = Array()
        var dateOffset: Date = date.addingTimeInterval(60 * 60 * 1)
        
        for string: String in self.timelineEntries {
            timelineEntries.append(self.createTimelineEntry(headerText: "Top 10", bodyText: string, date: dateOffset))
            
            dateOffset = dateOffset.addingTimeInterval(60 * 60 * 1)
        }
        
        handler(timelineEntries)
    }
    
    // MARK: - Placeholder Template 
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        
        if complication.family != .modularLarge {
            handler(nil)
        }
        
        let modularLarge: CLKComplicationTemplateModularLargeStandardBody = CLKComplicationTemplateModularLargeStandardBody()
        modularLarge.headerTextProvider = CLKSimpleTextProvider(text: "Top Song")
        modularLarge.body1TextProvider = CLKSimpleTextProvider(text: "---")
        modularLarge.body2TextProvider = CLKSimpleTextProvider(text: "---")
        
        handler(modularLarge)
    }
    
    // MARK: - Helper Methods 
    func createTimelineEntry(headerText: String, bodyText: String, date: Date) -> CLKComplicationTimelineEntry {
        
        let modularLarge: CLKComplicationTemplateModularLargeStandardBody = CLKComplicationTemplateModularLargeStandardBody()
        modularLarge.headerTextProvider = CLKSimpleTextProvider(text: "Top Song")
        modularLarge.body1TextProvider = CLKSimpleTextProvider(text: bodyText)
        modularLarge.body2TextProvider = CLKSimpleTextProvider(text: "")
        
        return CLKComplicationTimelineEntry(date: date, complicationTemplate: modularLarge)
    }
}
