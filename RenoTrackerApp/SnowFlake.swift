//
//  SnowFlake.swift
//  RenoTrackerApp
//
//  Created by Thilagawathy Duraisamy on 31/7/2023.
//

import SwiftUI

struct SnowFlake: Shape {
    func path(in rect: CGRect) -> Path {
        var mainPath = Path()
        let height: CGFloat = rect.size.height
        let width: CGFloat = rect.size.width
        let xCenter: CGFloat = width / 2
        let yCenter: CGFloat = height / 2
        let stemStartX: CGFloat = height * 0.15
        let stemEndY: CGFloat = height * 0.05
        let leadingStemEndX: CGFloat = width * 0.35
        let trailingStemEndX: CGFloat = width * 0.65
        var snowFlake = Path()
        
        snowFlake.move(to: CGPoint(x: xCenter, y: 0))
        snowFlake.addLine(to: CGPoint(x: xCenter, y: yCenter))
        snowFlake.move(to: CGPoint(x: xCenter, y: stemStartX))
        snowFlake.addLine(to: CGPoint(x: leadingStemEndX, y: stemEndY))
        snowFlake.move(to: CGPoint(x: xCenter, y: stemStartX))
        snowFlake.addLine(to: CGPoint(x: trailingStemEndX, y: stemEndY))
        
        for i in 1...6{
            let rotationAngle = Angle(degrees: Double(60 * i))
            let rotateTransform = CGAffineTransform.identity
            // .scaledBy(x: xCenter, y: yCenter)
                .translatedBy(x: xCenter, y: yCenter)
                .rotated(by: rotationAngle.radians)
                .translatedBy(x: -xCenter, y: -yCenter)
            
            let snowBranchPath =  snowFlake.applying(rotateTransform)
            mainPath.addPath(snowBranchPath)
        }
     return mainPath
    }
    
}

struct SnowFlake_Previews: PreviewProvider {
    static var previews: some View {
        SnowFlake()
            .stroke(.blue, lineWidth: 5)
            .frame(width: 100, height: 100, alignment: .center)
            
    }
}
