//
//  ScanView.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/22/22.
//

import SwiftUI
import AVKit
import AVFoundation

struct ScanInfoView: View {
    
   
    @Binding var startGame: Bool
    
    @State private var getStarted = false
    
    var body: some View {
        
        if(!getStarted) {
            
            VStack {
                VStack(alignment: .center, spacing: 10) {
                    PlayerView()
                        .frame(width: 320, height: 320)
                    GeneralTitle(text: "How to scan your hand")
                    Text("First, position your hand in the camera frame. Then wait for your hand to be found.")
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 250)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action:{getStarted = true}) {
                    RoundedButton(foregroundColor: .black, background: .white, text: "Get started")
                }
            }
            .darkStyle()
        } else {
            ScanView(startGame: $startGame)
        }
    }
}

struct ScanInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ScanInfoView(startGame: .constant(true))
    }
}

struct PlayerView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }
    
    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(frame: .zero)
    }
}


class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Load the resource
        let fileUrl = Bundle.main.url(forResource: "handputAnimation", withExtension: "mov")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        
        // Setup the player
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        // Create a new player looper with the queue player and template item
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        
        // Start the movie
        player.play()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
