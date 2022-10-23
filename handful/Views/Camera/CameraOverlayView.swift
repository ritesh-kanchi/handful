//
//  CameraOverlay.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/22/22.
//

import Foundation
import Vision
import SwiftUI

struct CameraOverlayView: View {
    
    var overlayPoints: [FingerJointPointCG]
    
    var body: some View {
        ZStack {
            ZStack {
                ForEach(overlayPoints) { point in
                    Circle()
                        .fill(.white)
                        .frame(width: 5, height: 5)
                        .position(x: point.location.x, y: point.location.y)
                        .tag(point.id)
                    
                }
                
                if(overlayPoints.contains{$0.finger == .wrist}) {
                    Circle()
                        .fill(.white.opacity(0.5))
                        .frame(width: 5, height: 5)
                        .position(x: overlayPoints.filter{$0.finger == .wrist}[0].location.x, y: overlayPoints.filter{$0.finger == .wrist}[0].location.y)
                }
            }
            ZStack {
                if(!overlayPoints.isEmpty) {
                    
                    ForEach(FingerType.allCases.filter { $0.rawValue != "wrist"}, id:\.self) { type in
                        Path { path in
                            
                            let points = overlayPoints.filter { $0.finger == type }
                            
                            let wristPoint = overlayPoints.filter{$0.finger == .wrist}
                            
                            if(!points.isEmpty) {
                                path.move(to: wristPoint.isEmpty  ?  points[0].location : wristPoint[0].location)
                                
                                for point in points.reversed() {
                                    path.addLine(to: point.location)
                                }
                                
                                
                            }
                            
                        }
                       
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.white.opacity(0.25)]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 2, dash: [5]))
                        
                    }
                }
                
            }
            
        }
    }
}

