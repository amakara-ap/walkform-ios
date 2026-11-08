import Foundation
import AVFoundation

class VoiceCoach: ObservableObject {
    private let synthesizer = AVSpeechSynthesizer()
    @Published var lastSpokenMessage: String = "背筋を伸ばして、リズミカルに！"
    
    private let coachAdviceList = [
        "背筋を伸ばして、リズミカルに！",
        "素晴らしい歩行リズムです。骨盤のブレがありません。",
        "視線を少し上げると、歩幅が自然に広がります。",
        "左右の荷重バランスが整っています。この調子！",
        "腕を後ろに引く意識で、体幹が活性化します。"
    ]
    
    func speakAdvice(custom: String? = nil) {
        let text = custom ?? coachAdviceList.randomElement() ?? "良い姿勢をキープできています！"
        lastSpokenMessage = text
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        utterance.rate = 0.52
        utterance.pitchMultiplier = 1.05
        
        // Stop any previous speech
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        synthesizer.speak(utterance)
    }
}
