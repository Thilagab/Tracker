//
//  RenovationProjectRow.swift
//  RenoTrackerApp
//
//  Created by Thilagawathy Duraisamy on 7/6/2023.
//

import SwiftUI

struct RenovationProjectRow: View {
    @Binding var renovationProject: RenovationProject
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image(renovationProject.imageName)
                    .resizable()
                    .frame(width: 100,height: 100)
                    .aspectRatio( contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                VStack (alignment: .leading){
                    Text(renovationProject.renovationArea)
                        .bold()
                    VStack(alignment: .leading){
                       
                        Label(renovationProject.dueDate.formatted(), systemImage: "calendar")
                        Label(renovationProject.punchList.count.description , systemImage: "wrench.and.screwdriver.fill")
                        Label("80% completed", systemImage: "percent")
                        Label("On budget", systemImage: "dollarsign.circle")
                        
                    }.foregroundColor(.blue)
                        .font(.system(size: 13.5))
                }
                Spacer()
            }
        }.padding(.trailing, 0.0)
      }
}

struct RenovationProjectRow_Previews: PreviewProvider {
    static var previews: some View {
        RenovationProjectRow(renovationProject: .constant(RenovationProject.testData[0]))
    }
}
