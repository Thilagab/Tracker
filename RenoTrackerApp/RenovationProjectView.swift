//
//  RenovationProjectView.swift
//  RenoTrackerApp
//
//  Created by Thilagawathy Duraisamy on 31/5/2023.
//

import SwiftUI

struct RenovationProjectView: View {
    @Binding var renovationProject: [RenovationProject]
    
    var body: some View {
        if renovationProject.count != 0 {
            NavigationView {
                List{
                    ForEach($renovationProject, id: \.projectNumber) { project in
                        NavigationLink {
                            DetailView(renovationProject: project)
                        } label: {
                            RenovationProjectRow(renovationProject: project)
                        }
                    }
                }
                .navigationTitle("Home")
            
            }
            
        }
    }
}

struct RenovationProjectView_Previews: PreviewProvider {
    struct RenPreview: View {
        
        @State var testRen = RenovationProject.testData
        
        var body: some View {
            
            RenovationProjectView(renovationProject: $testRen)
        }}
    static var previews: some View{
        RenPreview()
    }
}
   
