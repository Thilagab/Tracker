//
//  SnowflakeProg.swift
//  RenoTrackerApp
//
//  Created by Thilagawathy Duraisamy on 3/8/2023.
//

import SwiftUI

struct SnowflakeProg: View {
    @State var value: Double
    
    func FormatPercentage() -> String {
        var percentValueString = NumberFormatter()
        percentValueString.numberStyle = .percent
        return percentValueString.string(from: NSNumber(value: value)) ?? "0%"
    }
    
    var body: some View {
        HStack {
            GeometryReader { geometryReader in
                ZStack(alignment: .leading) {
                    Capsule(style: .continuous)
                        .opacity(0.3)
                        .foregroundColor(.accentColor)
                    
                    Capsule(style: .continuous)
                        .opacity(1.0)
                        .foregroundColor(.blue)
                        .frame(width: geometryReader.size.width * CGFloat(value), height: geometryReader.size.height)
                    SnowFlake()
                        .stroke(.white, lineWidth: 3)
                        .frame(width: geometryReader.size.height - 2, height: geometryReader.size.height - 2)
                        .offset(x: CGFloat( geometryReader.size.width * CGFloat(value) - geometryReader.size.height ))
                }.animation(.linear(duration: 0.9), value: value)
            }
            .frame(maxHeight: 20)
            
            Spacer()
            Text("\(FormatPercentage()) completed")
        }
    }
}

struct SnowflakeProg_Previews: PreviewProvider {
    static var previews: some View {
        SnowflakeProg(value: 0.9)
    }
}
