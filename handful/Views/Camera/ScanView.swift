//
//  ScanView.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/22/22.
//

import SwiftUI

struct ScanView: View {
    
    @State private var overlayPoints: [FingerJointPointCG] = []
    
    @Binding var startGame: Bool
    
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 20) {
                CameraBlockView(overlayPoints: $overlayPoints)
                VStack(alignment: .center, spacing: 10) {
                    GeneralTitle(text: "Position your hand within the frame.")
                        .multilineTextAlignment(.center)
                    if(overlayPoints.isEmpty) {
                        Text("No hand found.")
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 250)
                            .foregroundColor(.gray)
                    } else {
                        Text("Hand found!")
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 250)
                            .foregroundColor(.gray)
                        
                    }
                }
            }
            Spacer()
            if(!overlayPoints.isEmpty) {
                Button("Press here to continue") {
                    startGame = false
                }
                .disabled(overlayPoints.isEmpty)
                .opacity(overlayPoints.isEmpty ? 0.5 : 1)
            }
            
        }
        .darkStyle()
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView(startGame: .constant(true))
    }
}

struct CameraBlockView: View {
    
    @State private var animateGradient = true
    
    @Binding var overlayPoints: [FingerJointPointCG]
    
    @StateObject var camera = CameraModel()
    
    @State private var timeRemaining = 3
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            CameraView(camera: camera) {
                overlayPoints = $0
            }
            .overlay {
                CameraOverlayView(overlayPoints: overlayPoints)
            }
            .frame(width: 360, height: 360)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay{
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .strokeBorder(.black.opacity(0.25), style: StrokeStyle(lineWidth: 5))
            }
            .fixedSize()
        }
        .frame(width: 380, height: 380)
        .overlay{
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .strokeBorder(LinearGradient(colors: [Color(hex: "#E9F5C7"), Color(hex:"#FFC0FC")], startPoint: animateGradient ? .topTrailing : .bottomTrailing, endPoint: animateGradient ? .bottomLeading : .topLeading)
                              , style: StrokeStyle(lineWidth: 20))
        }
        .onAppear(perform: {
            camera.Check()
            withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        })
    }
}
