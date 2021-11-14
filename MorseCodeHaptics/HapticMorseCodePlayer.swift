//
//  HapticMorseCodePlayer.swift
//  MorseCodeHaptics
//
//  Created by Eric Davis on 14/11/2021.
//

import Foundation
import CoreHaptics

final class HapticsMorseCodePlayer: MorseCodePlayer {
    let hapticsEngine: CHHapticEngine
    
    init() throws {
        hapticsEngine = try CHHapticEngine()
        try hapticsEngine.start()
    }
    
    func play(message: MorseCodeMessage) throws {
        let events = hapticEvents(for: message)
        let pattern = try CHHapticPattern(events: events, parameters: [])
        let player = try hapticsEngine.makePlayer(with: pattern)

        try player.start(atTime: 0)
    }
    
    func hapticEvents(for message: MorseCodeMessage) -> [CHHapticEvent] {
        //todo
        var relativeTime = 0.0
        var events: [CHHapticEvent] = []
        for message in message.playbackEvents {
            switch message {
            case .on(let timeInterval):
                events += [CHHapticEvent(eventType: .hapticContinuous, parameters: [], relativeTime: relativeTime, duration: timeInterval)]
            case .off(_):
                break
            }
            relativeTime += message.duration
        }
        return events
    }
}


