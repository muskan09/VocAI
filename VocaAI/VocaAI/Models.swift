//
//  Models.swift
//  VocaAI
//
//  Created by Muskan Kalsi on 5/24/24.
//

import Foundation

enum VoiceType: String, Codable, Hashable, Sendable, CaseIterable {
    case echo
    case nova
    case shimmer
    case onyx
    case alloy
    case fable
}

enum VoiceChatState {
    case idle
    case recordingSpeech
    case processingSpeech
    case playingSpeech
    case error(Error)
}
