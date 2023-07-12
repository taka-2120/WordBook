//
//  FlashCardController.swift
//  WordVenture
//
//  Created by Yu Takahashi on 7/7/23.
//

import Foundation
import AVFoundation
import NaturalLanguage

class FlashCardController: ObservableObject {
    
    @Published var isCardModeShown = false
    @Published var isAlwaysImageShown = false
    
    func speakWord(for word: String) {
        guard let languageCode = determineLanguage(for: word) else {
            print("Cannot speak this word")
            return
        }
        
        guard let supportedLanguage = getVoiceLanguage(for: languageCode) else {
            print("\(languageCode) is not supported on this device")
            return
        }
        print(supportedLanguage)
        
        let utterance = AVSpeechUtterance(string: word)
        utterance.pitchMultiplier = 1.0
        utterance.rate = 0.5
        utterance.voice = AVSpeechSynthesisVoice(language: supportedLanguage)
         
        
        let speechSynthesizer = AVSpeechSynthesizer()
        speechSynthesizer.speak(utterance)
    }
    
    private func determineLanguage(for word: String) -> String? {
        let languageRecognizer = NLLanguageRecognizer()
        languageRecognizer.processString(word)
        
        if let dominantLanguage = languageRecognizer.dominantLanguage {
            return dominantLanguage.rawValue
        }
        
        return nil
    }
    
    private func getVoiceLanguage(for code: String) -> String? {
        let voices = AVSpeechSynthesisVoice.speechVoices()
        var candidates = [String]()
         
        for voice in voices {
            if voice.language.contains(code) {
                candidates.append(voice.language)
            }
        }
        
        if candidates.isEmpty {
            return nil
        }
        
        let localeCode = Locale.current.identifier.dropFirst(3)
        let lanauageCode = "\(code)-\(localeCode)"
        
        if candidates.contains(where: { $0.contains(lanauageCode) }) {
            return lanauageCode
        }
        
        return candidates.first
    }
}
