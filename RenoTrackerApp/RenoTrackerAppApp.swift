//
//  RenoTrackerAppApp.swift
//  RenoTrackerApp
//
//  Created by Thilagawathy Duraisamy on 31/5/2023.
//

import SwiftUI

@main
struct RenoTrackerAppApp: App {
    @State private var renovationProject = [RenovationProject]()
    private var dataManager = RenovationDataManager()
    @Environment(\.scenePhase) var scenePhase
   
  
    var body: some Scene {
        WindowGroup {
          
            RenovationProjectView(renovationProject: $renovationProject)
                .onAppear {
                    dataManager.load { renovationProject in
                        self.renovationProject = renovationProject }
                }
                .onChange(of: scenePhase) { newValue in
                    if newValue == .background {
                        dataManager.saveJsonData(renovationProject: self.renovationProject)
                    }
                }
        }
    }
}
