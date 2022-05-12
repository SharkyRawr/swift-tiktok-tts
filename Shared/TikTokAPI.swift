//
//  TikTokAPI.swift
//  tiktok-tts
//
//  Created by Sophie Luna Schumann on 12.05.22.
//

import Foundation

public enum TikTokAPIError: Error {
    case InvalidURLError
    case ApiError
    case CustomError(String?)
    case InnerError(Error)
}


public class TikTokAPI {
    static let api_url: String = "https://api16-normal-useast5.us.tiktokv.com/media/api/text/speech/invoke/?text_speaker=%@&req_text=%@&speaker_map_type=0";
    static func Speak(text: String, completion: @escaping (TTS)->(), error: @escaping (TikTokAPIError)->()) throws -> Void {
        let fixedText = text.replacingOccurrences(of: " ", with: "%20")
        guard let myUrl = URL(string: String(format: api_url, "en_us_001", fixedText)) else {
            throw TikTokAPIError.InvalidURLError
        }
        
        var request = URLRequest(url: myUrl);
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) {
            (data, response, err) in
            if let err = err {
                error(TikTokAPIError.InnerError(err))
                return
            }
            guard let data = data else {
                error(TikTokAPIError.CustomError("Data error"))
                return
            }
            do {
                let tts =  try TTS(data: data)
                completion(tts)
                return
            } catch (let err) {
                error(TikTokAPIError.InnerError(err))
                return
            }
        }.resume()
    }
}

var api =  TikTokAPI();
