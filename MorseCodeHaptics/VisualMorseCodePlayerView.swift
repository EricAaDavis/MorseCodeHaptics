//
//  MorseCodeMessageView.swift
//  MorseCodeHaptics
//
//  Created by Eric Davis on 14/11/2021.
//

import UIKit

class VisualMorseCodePlayerView: UIView, MorseCodePlayer {
    func play(message: MorseCodeMessage) throws {
        var relativeTime = 0.0
        for message in message.playbackEvents {
            print(message.duration)
            switch message {
            case .on(let duration):
                Timer.scheduledTimer(withTimeInterval: relativeTime, repeats: false) { _ in
                    self.backgroundColor = .white
                }
            case .off(let duration):
                Timer.scheduledTimer(withTimeInterval: relativeTime, repeats: false) { _ in
                    self.backgroundColor = .black
                }
            }
            relativeTime += message.duration
        }
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
