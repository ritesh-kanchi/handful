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
    
    let totalJoints = points.count
    
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
    
    if tips >= 4 && fullDips && fullPips && fullIps  {
        return .open
    }
    
    if totalJoints >= 12 && tips >= 2 && dips >= 3 && pips >= 3 {
        return .two
    }
    
    if totalJoints >= 9 && dips >= 3 && pips >= 3  {
        return .three
    }
    
    if totalJoints <= 10 {
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
