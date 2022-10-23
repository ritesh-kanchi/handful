//
//  CameraRPSOverlayView.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/22/22.
//

import SwiftUI

struct CameraRPSOverlayView: View {
    
    var overlayPoints: [FingerJointPointCG]
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct CameraRPSOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        CameraRPSOverlayView(overlayPoints: [])
    }
}
