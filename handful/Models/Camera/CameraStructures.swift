//
//  CameraStructures.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/22/22.
//

import Foundation
import Vision

struct FingerJointPoint {
    var recognizedPoint: VNRecognizedPoint
    var type: JointType
    var finger: FingerType
}

struct FingerJointPointCG: Identifiable {
    var id = UUID()
    var location: CGPoint
    var type: JointType
    var finger: FingerType
}

