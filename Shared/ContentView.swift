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
    
    @State private var avAudio: AVAudioPlayer!
    
    func speak() -> Void {
        do {
            try TikTokAPI.Speak(text: txt, completion: { json in
                txt = json.statusMsg
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
            TextField("Text to Speech", text: $txt)
                .onSubmit {
                    speak();
                }
                .border(.secondary)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button(action: speak) {
                Text("Speak")
            }
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
