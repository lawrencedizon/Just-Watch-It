//
//  DateConverter.swift
//  JustWatchIt
//
//  Created by Lawrence Dizon on 5/28/21.
//

import Foundation

class DateConverterHelper {
    //Converts an entire date string to return only the year
    static public func getYear(date: String) -> String{
        if let year = date.components(separatedBy: "-").first {
            return year
        }
        return ""
    }
}
