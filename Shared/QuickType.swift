// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let tTS = try TTS(json)

import Foundation

// MARK: - TTS
struct TTS: Codable {
    let data: DataClass
    let extra: Extra
    let message: String
    let statusCode: Int
    let statusMsg: String

    enum CodingKeys: String, CodingKey {
        case data, extra, message
        case statusCode = "status_code"
        case statusMsg = "status_msg"
    }
}

// MARK: TTS convenience initializers and mutators

extension TTS {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TTS.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        data: DataClass? = nil,
        extra: Extra? = nil,
        message: String? = nil,
        statusCode: Int? = nil,
        statusMsg: String? = nil
    ) -> TTS {
        return TTS(
            data: data ?? self.data,
            extra: extra ?? self.extra,
            message: message ?? self.message,
            statusCode: statusCode ?? self.statusCode,
            statusMsg: statusMsg ?? self.statusMsg
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let sKey, vStr, duration: String

    enum CodingKeys: String, CodingKey {
        case sKey = "s_key"
        case vStr = "v_str"
        case duration
    }
}

// MARK: DataClass convenience initializers and mutators

extension DataClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DataClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        sKey: String? = nil,
        vStr: String? = nil,
        duration: String? = nil
    ) -> DataClass {
        return DataClass(
            sKey: sKey ?? self.sKey,
            vStr: vStr ?? self.vStr,
            duration: duration ?? self.duration
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Extra
struct Extra: Codable {
    let logID: String

    enum CodingKeys: String, CodingKey {
        case logID = "log_id"
    }
}

// MARK: Extra convenience initializers and mutators

extension Extra {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Extra.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        logID: String? = nil
    ) -> Extra {
        return Extra(
            logID: logID ?? self.logID
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
