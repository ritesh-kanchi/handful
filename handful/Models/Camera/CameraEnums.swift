//
//  CameraEnums.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/22/22.
//

import Foundation

enum GestureType {
    case open
    case closed
    case one
    case two
    case three
    case undefined
}

enum JointType {
    case tip
    case dip
    case pip
    case mcp
    case ip
    case cmc
    case mp
    case wrist
}

enum FingerType: String, CaseIterable {
    case thumb
    case index
    case middle
    case ring
    case little
    case wrist
}
