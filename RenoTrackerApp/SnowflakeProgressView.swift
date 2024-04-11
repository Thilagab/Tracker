//
//  SnowflakeProgressView.swift
//  RenoTrackerApp
//
//  Created by Thilagawathy Duraisamy on 1/8/2023.
//

import SwiftUI

struct SnowflakeProgressView: View {
    var body: some View {
        GeometryReader { geoReader in
            ZStack{
                ProgressView(value: 0.5)
                    .progressViewStyle(snowflakeSytle())
                
                SnowFlake()
                    .stroke(.brown, lineWidth: 3)
                    .frame(width: 20, height: 20, alignment: .center)
                    .position(x: geoReader.size.width/5.5, y: 60)
                
            }.frame(width: 100, height: 100, alignment: .center)
        }
    }
}

struct snowflakeSytle: ProgressViewStyle  {
    
    func makeBody(configuration: Configuration) -> some View {
        let complete = configuration.fractionCompleted ?? 0
        
        let angle = Angle(degrees: 12)
        return ZStack {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color(.sRGB, white: 0, opacity: 0.2), lineWidth: 10)
                .frame(width: 50, height: 50, alignment: .center)
            Circle()
                .trim(from: 0, to: complete)
                .stroke(.blue,style: StrokeStyle(lineWidth: 10, lineCap: .round))
            //  .stroke(Color(.displayP3, white: 0, opacity: 0.5), lineWidth: 10)
                .frame(width: 50, height: 50, alignment: .center)
                .rotationEffect(.degrees(-90))
                .animation(.easeIn, value: 2)
            //            SnowFlake()
            //                .stroke(.blue, lineWidth: 3)
            //                .frame(width: 30, height: 20, alignment: .center)
            
        }
          
    
        
    }
    
    
    
}

struct SnowflakeProgressView_Previews: PreviewProvider {
    static var previews: some View {
        SnowflakeProgressView()
    }
}
