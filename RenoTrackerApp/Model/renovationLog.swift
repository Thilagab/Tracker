//
//  renovationLog.swift
//  RenoTrackerApp
//
//  Created by Thilagawathy Duraisamy on 7/8/2023.
//

import Foundation

extension InspectionLogEntry {
   
    static var testLogEntry: [InspectionLogEntry] {
        let dateInFormat = DateFormatter()
        dateInFormat.dateFormat = "dd/MM/yyyy"
 
        return [ InspectionLogEntry(entryDate: dateInFormat.date(from: "20/02/2022")!, details: "Lobby area review") ,
                 InspectionLogEntry(entryDate: dateInFormat.date(from: "18/05/2022")!, details: "Main Room review")
        ]
    }
}
