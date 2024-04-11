//
//  InspectionLogView.swiftºº
//  RenoTrackerApp
//
//  Created by Thilagawathy Duraisamy on 31/5/2023.
//

import SwiftUI

struct InspectionLogView: View {
    var logEntry: [InspectionLogEntry]
    @State var sortAscending: Bool = true
    var sortedEntry: [InspectionLogEntry] {
        logEntry.sorted {  //print(self.sortedEntry)
           return sortAscending ?  $0.entryDate < $1.entryDate : $0.entryDate > $1.entryDate }
    }
    var body: some View {
      
        VStack {
            Button(role: nil, action: {
                withAnimation {
                    sortAscending.toggle()
                }
                
            }, label: {
                Text("sort")
                Image(systemName: "arrow.up.square")
                    .rotationEffect( Angle(degrees: (sortAscending ? 0 : 180)))
            })
            List {
                ForEach(sortedEntry, id: \.details, content: { entry in
                    VStack(alignment: .leading) {
                      
                        Text(entry.entryDate.formatted())
                        Text(entry.details)
                    }
                })
            }.navigationTitle("Log Entry")
        }
    }
}

struct InspectionLogView_Previews: PreviewProvider {
    static var previews: some View {
        InspectionLogView(logEntry: InspectionLogEntry.testLogEntry)
    }
}
