//
//  EditView.swift
//  RenoTrackerApp
//
//  Created by Thilagawathy Duraisamy on 31/5/2023.
//

import SwiftUI

struct EditView: View {
    @Binding var renovationProject: RenovationProject
    
    var body: some View {
            Form {
                Section("Budget Info", content: {
                    
                   TextField("Renavtion area", text: $renovationProject.renovationArea)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.sentences)
                    
                    DatePicker("Due Date", selection: $renovationProject.dueDate, displayedComponents: .date)
                        .datePickerStyle(DefaultDatePickerStyle())
                    HStack() {
                        
                        Picker("Quality rating",selection: $renovationProject.workQuality) {
                            ForEach(RenovationProject.WorkQualityRating.allCases, id:\.self ) {quality in
                                Text(quality.rawValue).tag(quality) } }.pickerStyle(NavigationLinkPickerStyle())
                    }
                    Toggle("Flagged for review", isOn: $renovationProject.isFlagged)
                
                })
                
                Section("Punch List") {
                    ForEach(renovationProject.punchList, id: \.task) { punchListItem in
                        
                        let bindingItemIndex = renovationProject.punchList.firstIndex(where: { $0.task == punchListItem.task })!
                        let bindingItemStatus = $renovationProject.punchList[bindingItemIndex]
                        
                        Picker(punchListItem.task, selection: bindingItemStatus.status, content: {
                            ForEach(PunchListItem.CompletionStatus.allCases, id: \.self) { status in
                                Text(status.rawValue).tag(status) } }).pickerStyle(NavigationLinkPickerStyle())
                    }
                }
                Section("Budget") {
                    TextField("Budget on Date", value: $renovationProject.budgetSpentToDate, formatter: NumberFormatter())
                }
        }
    }
}

struct EditView_Previews: PreviewProvider {
  
    static var previews: some View {
             EditView(renovationProject: .constant(RenovationProject()))
               
    }
}
