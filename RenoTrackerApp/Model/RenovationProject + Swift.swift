//
//  RenovationProject + Swift.swift
//  RenoTrackerApp
//
//  Created by Thilagawathy Duraisamy on 16/8/2023.
//

import Foundation

extension RenovationProject {
   
    var formatedDueDate: String {
        var formatter  =  DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        return formatter.string(from: dueDate)
        
    }
    var totalPunchListItems: Int {
        return punchList.count
    }
    var percentComplete: Double {
        let completePunchListItems = punchList.filter { punchListItem in
            punchListItem.status == .complete
        }
        
        let percentComplete = Double(completePunchListItems.count) / Double(totalPunchListItems)
        
        return percentComplete
    }
}
