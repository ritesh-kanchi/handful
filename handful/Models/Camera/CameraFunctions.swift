//
//  CameraFunctions.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/22/22.
//

import Foundation
import SwiftUI


func getJointColor(_ point: FingerJointPointCG) -> Color {
    switch point.type {
    case .tip:
        return .blue
    case .dip:
        return .green
    case .pip:
        return .yellow
    case .mcp:
        return .orange
    case .ip:
        return .green
    case .mp:
        return .yellow
    case .cmc:
        return .orange
    default:
        return .white
    }
}

func getGesture(_ points: [FingerJointPointCG]) -> GestureType {
    
    let totalJoints = points.filter({ $0.type != .wrist }).count
    
    let tips = points.filter({ $0.type == .tip }).count
    let pips = points.filter({ $0.type == .pip }).count
    let dips = points.filter({ $0.type == .dip }).count
    let mcps = points.filter({ $0.type == .mcp }).count
    
    let ips = points.filter({ $0.type == .ip }).count
    let mps = points.filter({ $0.type == .mp }).count
    let cmcs = points.filter({ $0.type == .cmc }).count
    
    let wrist = points.filter({ $0.type == .wrist }).count
    
    let maxTips = 5
    let maxPips = 4
    let maxDips = 4
    let maxMcps = 4
    
    let maxIps = 1
    let maxMps = 1
    let maxCmcs = 1
    
    let maxWrist = 1
    
    let fullTips = maxTips == tips
    let fullPips = maxPips == pips
    let fullDips = maxDips == dips
    let fullMcps = maxMcps == mcps
    
    let fullIps = maxIps == ips
    let fullMps = maxMps == mps
    let fullCmcs = maxCmcs == cmcs
    
    let fullWrist = wrist == maxWrist
    
    if tips >= 5 && fullDips && fullPips && fullIps  {
        return .open
    }
    
    
    if totalJoints <= 20 && totalJoints >= 11 && tips >= 1 && tips < 5 {
        return .two
    }
    
    if totalJoints <= 9 && totalJoints >= 3 {
        return .closed
    }

    
    return .undefined
}

func getGestureIdentification(_ gesture: GestureType) -> String {
    switch gesture {
    case .open:
        return "Open"
    case .closed:
        return "Closed"
    case .one:
        return "One Finger"
    case .two:
        return "Two Fingers"
    case .three:
        return "Three Fingers"
    default:
        return "Undefined"
    }
}


func getDistanceResponse(_ handDist: HandDistances) -> String {
    switch handDist {
    case .near:
        return "Pull your hand back."
    case .far:
        return "Bring your hand in closer."
    default:
        return ""
    }
}

func getCGDistance(point1: CGPoint, point2: CGPoint) -> Double {
    
    let distance = sqrt(pow((point1.x - point2.x), 2)+pow((point1.y - point2.y), 2))
    
    print(distance)
    
    return distance
    
}

func determineDistanceFromScreen(points: [FingerJointPointCG]) -> HandDistances {
    
    if !points.isEmpty && points.count > 2 {
        let point1 = points.contains {$0.finger == .wrist} ? points.filter {$0.finger == .wrist}[0].location : points[0].location
        
        let point2 = points.contains {$0.finger == .index && $0.type == .tip} ? points.filter {$0.finger == .index && $0.type == .tip}[0].location : points[1].location
        
        let distance = getCGDistance(point1: point1, point2: point2)
        
        if points.count >= 20 && distance < 280 && distance > 100 {
           return .ideal
       } else if distance > 280 || (points.count < 17 && distance < 200) {
            return .near
        } else if distance < 100 {
            return .far
        }
    }
    
    return .undefined
    
}
