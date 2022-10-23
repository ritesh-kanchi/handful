//
//  GameFunctions.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/23/22.
//

import Foundation

func getEmojiFromType(_ type: RPSType) -> String {
    switch type {
    case .rock:
        return "✊"
    case .scissors:
        return "✌️"
    case .paper:
        return "✋"
    default:
        return "🤖"
    }
}

func getTextFromType(_ type: RPSType) -> String {
    switch type {
    case .rock:
        return "Rock"
    case .scissors:
        return "Scissors"
    case .paper:
        return "Paper"
    default:
        return "Unknown"
    }
}


func gestureToOption(_ overlayPoints: [FingerJointPointCG]) -> RPSType {
    let gesture = getGesture(overlayPoints)
    
    switch gesture {
    case .open:
        return .paper
    case .closed:
        return .rock
    case .two:
        return .scissors
    default:
        return .undefined
    }
}
