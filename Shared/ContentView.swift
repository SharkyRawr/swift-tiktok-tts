//
//  ContentView.swift
//  Shared
//
//  Created by Sophie Luna Schumann on 12.05.22.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var txt: String = ""
    @State private var showError: Bool = false
    @State private var alertMsg: String = ""
    @State private var voice: String = TikTokVoice.VoiceEnglishFem1.rawValue
    
    @State private var avAudio: AVAudioPlayer!
    
    func speakGibberish() -> Void {
        txt = GenerateGibberish()
    }
    
    func speak() -> Void {
        let v = TikTokVoice.init(rawValue: voice)!
        do {
            try TikTokAPI.Speak(voice: v, text: txt, completion: { json in
                // txt = json.statusMsg
                let data = Data(base64Encoded: json.data.vStr)!
                do {
                    avAudio = try AVAudioPlayer(data: data);
                    avAudio.prepareToPlay()
                    avAudio.play()
                }  catch (let err) {
                    showError = true
                    alertMsg = err.localizedDescription
                }
            }, error: { err in
                showError = true
                alertMsg = err.localizedDescription
            })
        }
        catch TikTokAPIError.InvalidURLError {
            alertMsg = "Unable to create URL request from input!";
            showError = true;
        }
        catch TikTokAPIError.ApiError {
            alertMsg = "TikTok API did not like that. Try something else. 🙃";
            showError = true;
        }
        catch {
            return
        }
    }
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.center) {
            Picker(selection: $voice, label: Text("Voice")){
                ForEach(TikTokVoice.allCases, id: \.self) {
                    value in
                    Text(String(describing: value)).tag(value.rawValue)
                }
            }
            .padding()
            TextField("Text to Speech", text: $txt)
                .onSubmit {
                    speak();
                }
                .border(.secondary)
                .textFieldStyle(.roundedBorder)
                .padding()
            HStack(alignment: .center) {
                Button(action: speakGibberish) {
                    Text("Random gibberish")
                }
                Button(action: speak) {
                    Text("Speak")
                }
            }
            .padding([.bottom], 20)
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("👏 Error"), message: Text(alertMsg), dismissButton: .default(Text("Got it")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
