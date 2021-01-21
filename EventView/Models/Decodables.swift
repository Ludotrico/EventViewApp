//
//  Decodables.swift
//  EventView
//
//  Created by Ludovico Veniani on 1/20/21.
//

import Foundation

internal let dateFormatter = DateFormatter()

class Event: Decodable {
    var id: Int
    var name: String
    var location: String
    var start: String
    var end: String
    var attending: Int
    
    func getDate(getStart: Bool) -> String {
        let dateString = getStart ? self.start : self.end
        
   
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)!
        
        

        
        
        return Event.getTimeWithMonth(date: date)
    }
    
   
    
    static func getTime(date: Date) -> String {
        let calendar = Calendar.current
        var ext = "AM"
        var hour = calendar.component(.hour, from: date)
        if hour >= 12 {
            ext = "PM"
        }
        if hour > 12 {
            hour -= 12
        }
        hour = hour == 0 ? 12 : hour

        let minutes = calendar.component(.minute, from: date)
        return "\(hour):\(minutes < 10 ? "0" : "")\(minutes) \(ext)"
    }
    

    
    static func getTimeWithMonth(date: Date) -> String {
        dateFormatter.dateFormat = "MMM dd"
        let monthComponent = dateFormatter.string(from: date).capitalized

        return "\(monthComponent), \(Event.getTime(date: date))"
    }
    
   
}
