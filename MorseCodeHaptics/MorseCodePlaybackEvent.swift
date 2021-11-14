//
//  MorseCodePlaybackEvent.swift
//  MorseCodeHaptics
//
//  Created by Eric Davis on 13/11/2021.
//

import Foundation

enum MorseCodePlaybackEvent {
    case on(TimeInterval)
    case off(TimeInterval)
    
    var duration: TimeInterval {
        switch self {
        case .on(let duration):
            return duration
        case .off(let duration):
            return duration
        }
    }
    
}
