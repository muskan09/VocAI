//
//  ContentView.swift
//  VocaAI
//
//  Created by Muskan Kalsi on 5/24/24.
//

import SwiftUI
import SiriWaveView

struct ContentView: View {
    
    @State var vm = ViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            Text("VocaAI - Your New AI Voice Assistant").font(.title2)
            
            Spacer()
            SiriWaveView().power(power: vm.audioPower).opacity(vm.siriWaveFormOpacity).frame(height: 256).overlay{ overlayView}
            Spacer()
            
            switch vm.state {
            case.recordingSpeech:
                cancelRecordingButton
                
            case .processingSpeech, .playingSpeech:
                cancelButton
            default: EmptyView()
            }
            
            Picker("Select Voice", selection: $vm.selectedVoice){
                ForEach(VoiceType.allCases, id: \.self) {
                    Text($0.rawValue).id($0)
                }
            }
            .pickerStyle(.segmented)
            .disabled(!vm.isIdle)
            
            if case let .error(error) = vm.state {
                Text(error.localizedDescription).foregroundStyle(.red)
                    .font(.caption).lineLimit(2)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    var overlayView: some View {
        switch vm.state {
        case .idle, .error:
            startCaptureButton
        default: EmptyView()
        }
    }
    var startCaptureButton: some View{
        Button {vm.startCaptureAudio() } label: {Image(systemName: "mic.circle").symbolRenderingMode(.multicolor).font(.system(size: 128))}.buttonStyle(.borderless)
    }
    var cancelRecordingButton: some View{
        Button(role: .destructive){
            vm.cancelRecording()
        } label: {
            Image(systemName: "xmark.circle.fill").symbolRenderingMode(.multicolor).font(.system(size: 44))
        }.buttonStyle(.borderless)
    }
    var cancelButton: some View{
        Button(role: .destructive) { vm.cancelProcessingTask() } label: {
            Image(systemName: "stop.circle.fill").symbolRenderingMode(.monochrome).foregroundStyle(.red).font(.system(size: 44))
        }.buttonStyle(.borderless)
    }
}

#Preview("Idle") {
    ContentView()
}

#Preview("Recording Speech") {
    let vm = ViewModel()
    vm.state = .recordingSpeech
    return ContentView(vm: vm)
}

#Preview("Processing Speech") {
    let vm = ViewModel()
    vm.state = .recordingSpeech
    return ContentView(vm: vm)
}

#Preview("Playing Speech") {
    let vm = ViewModel()
    vm.state = .recordingSpeech
    return ContentView(vm: vm)
}

#Preview("Error") {
    let vm = ViewModel()
    vm.state = .error("An error has occured")
    return ContentView(vm: vm)
}
