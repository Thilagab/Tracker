//
//  RenavationDataManager.swift
//  RenoTrackerApp
//
//  Created by Thilagawathy Duraisamy on 15/6/2023.
//

import Foundation
import SwiftUI

struct RenovationDataManager {
    func load( completionHandler: @escaping ([RenovationProject]) -> Void ) {
        DispatchQueue.global(qos: .background).async {
            var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            path = path.appending(path: "RenovationData.json")
            if FileManager.default.fileExists(atPath: path.path()) == false {
                if let filePath = Bundle.main.url(forResource: "RenovationData", withExtension: "json") {
                    do {
                        try FileManager.default.copyItem(at: filePath, to: path)
                    }catch{
                        fatalError("Error occured while coping file")
                    }
                }
            }
            print("file path \(path)")
            do {
                let jsonData = try Data(contentsOf: path)
                print("jsonData:", jsonData)
                
                let jsonDecoder = JSONDecoder()
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "yyyy-MM-dd"
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormat)
                let dataMan = try jsonDecoder.decode([RenovationProject].self, from: jsonData)
                
                DispatchQueue.main.async {
                    completionHandler(dataMan)
                }
            }catch {
                fatalError("Error occured while coping the content \(path)")
            }
        }
    }
    
    func saveJsonData(renovationProject: [RenovationProject]) {
        
        DispatchQueue.global(qos: .background).async {
            var fileManager = FileManager()
            var urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appending(path: "RenovationData.json")
            
            if FileManager.default.fileExists(atPath: urlPath.absoluteString) {
                do{
                    let jsonEncoder = JSONEncoder()
                    let dateformat = DateFormatter()
                    dateformat.dateFormat = "yyyy-MM-dd"
                    jsonEncoder.dateEncodingStrategy = .formatted(dateformat)
                    let data = try jsonEncoder.encode(renovationProject)
                    try data.write(to: urlPath)
                }catch{
                    fatalError(error.localizedDescription)
                }
                    
            }
        }
        
    }
}
