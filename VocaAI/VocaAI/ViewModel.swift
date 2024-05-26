//
//  ViewModel.swift
//  VocaAI
//
//  Created by Muskan Kalsi on 5/24/24.
//
import AVFoundation
import Foundation
import Observation
import XCAOpenAIClient

@Observable
class ViewModel: NSObject {
    
    let client = OpenAIClient(apiKey: "")
    
    var selectedVoice = VoiceType.alloy
    var state = VoiceChatState.idle {
        didSet { print(state) }
    }
    var isIdle: Bool {
        if case .idle = state {
            return true
        }
        return false
    }
    
    var audioPower = 0.0
    var siriWaveFormOpacity: CGFloat {
        switch state {
        case .recordingSpeech, .playingSpeech: return 1
        default: return 0
        }
    }
    
    func startCaptureAudio() {
        
    }
    
    func cancelRecording() {
        
    }
    
    func cancelProcessingTask() {
        
    }
}

