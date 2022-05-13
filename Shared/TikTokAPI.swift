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

public enum TikTokVoice: String, CaseIterable {
    // US English Female 1
    case VoiceEnglishFem1 = "en_us_001"
    // US English Female 2
    case VoiceEnglishFem2 = "en_us_002"
    // US English Male 1
    case VoiceEnglishMal1 = "en_us_006"
    // US English Male 2
    case VoiceEnglishMal2 = "en_us_007"
    // US English Male 3
    case VoiceEnglishMal3 = "en_us_009"
    // US English Male 4
    case VoiceEnglishMal4 = "en_us_010"

    // Australian English Female
    case VoiceEnglishFemAU = "en_au_001"
    // Australian English Male
    case VoiceEnglishMalAU = "en_au_002"

    // UK English Male 1
    case VoiceEnglishMalGB = "en_uk_001"
    // UK English Male 2
    case VoiceEnglishMalGB2 = "en_uk_003"

    // French Male 1
    case VoiceFrenchMal1 = "fr_001"
    // French Male 2
    case VoiceFrenchMal2 = "fr_002"

    // German Female
    case VoiceGermanFem = "de_001"
    // German Male
    case VoiceGermanMal = "de_002"

    // Spanish Male
    case VoiceEspMal = "es_002"

    // Spanish (Mexican) Male
    case VoiceSpaMal = "es_mx_002"

    // Brazilian Female 1
    case VoiceBraFem1 = "br_001"
    // Brazilian Female 2
    case VoiceBraFem2 = "br_003"
    // Brazilian Female 3
    case VoiceBraFem3 = "br_004"
    // Brazilian Male
    case VoiceBraMal = "br_005"

    // Idonesian Male
    case VoiceIdoFem = "id_001"

    // Japanese Female 1
    case VoiceJpnFem1 = "jp_001"
    // Japanese Female 2
    case VoiceJpnFem2 = "jp_003"
    // Japanese Female 3
    case VoiceJpnFem3 = "jp_005"
    // Japanese Male
    case VoiceJpnMal = "jp_006"

    // Korean Male 1
    case VoiceKorMal1 = "kr_002"
    // Korean Female
    case VoiceKorFem = "kr_003"
    // Korean Male 2
    case VoiceKorMal2 = "kr_004"

    // Disney Ghostface
    case VoiceGhostface = "en_us_ghostface"
    // Disney Chewbacca
    case VoiceChewbacca = "en_us_chewbacca"
    // Disney C3P0
    case VoiceC3PO = "en_us_c3po"
    // Disney Stitch
    case VoiceStitch = "en_us_stitch"
    // Disney Stormtrooper
    case VoiceStormtrooper = "en_us_stormtrooper"
    // Disney Rocket
    case VoiceRocket = "en_us_rocket"
}


public class TikTokAPI {
    static let api_url: String = "https://api16-normal-useast5.us.tiktokv.com/media/api/text/speech/invoke/?text_speaker=%@&req_text=%@&speaker_map_type=0";
    static func Speak(voice: TikTokVoice, text: String, completion: @escaping (TTS)->(), error: @escaping (TikTokAPIError)->()) throws -> Void {
        let fixedText = text.replacingOccurrences(of: " ", with: "%20")
            .replacingOccurrences(of: "&", with: " and ")
            .replacingOccurrences(of: "+", with: " plus ")
        guard let myUrl = URL(string: String(format: api_url, voice.rawValue, fixedText)) else {
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
