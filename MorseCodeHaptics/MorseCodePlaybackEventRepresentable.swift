//
//  MorseCodePlaybackEventRepresentable.swift
//  MorseCodeHaptics
//
//  Created by Eric Davis on 13/11/2021.
//

import Foundation

protocol MorseCodePlaybackEventRepresentable {
    var playbackEvents: [MorseCodePlaybackEvent] { get }
    var components: [MorseCodePlaybackEventRepresentable] { get }
    var componentsSeperationDuration: TimeInterval { get }
}

extension MorseCodePlaybackEventRepresentable {
    var playbackEvents: [MorseCodePlaybackEvent] {
        components.flatMap { component in
            component.playbackEvents + [.off(componentsSeperationDuration)]
        }
    }
}

extension MorseCodeSignal: MorseCodePlaybackEventRepresentable {
    var playbackEvents: [MorseCodePlaybackEvent] {
        switch self {
        case .short:
            return [MorseCodePlaybackEvent.on(.morseCodeUnit)]
        case .long:
            return [MorseCodePlaybackEvent.on(.morseCodeUnit * 3)]
        }
    }
    var components: [MorseCodePlaybackEventRepresentable] { return [] }
    var componentsSeperationDuration: TimeInterval { 0.0 }
    
}

extension MorseCodeCharacter: MorseCodePlaybackEventRepresentable {
    var components: [MorseCodePlaybackEventRepresentable] { return signals }
    var componentsSeperationDuration: TimeInterval { return .morseCodeUnit }
}

extension MorseCodeWord: MorseCodePlaybackEventRepresentable {
    var components: [MorseCodePlaybackEventRepresentable] { characters }
    var componentsSeperationDuration: TimeInterval { .morseCodeUnit * 3 }
}

extension MorseCodeMessage: MorseCodePlaybackEventRepresentable {
    var components: [MorseCodePlaybackEventRepresentable] { words }
    var componentsSeperationDuration: TimeInterval { .morseCodeUnit * 7 }
}

extension TimeInterval {
    static let morseCodeUnit: TimeInterval = 0.3
}


