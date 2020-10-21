//
//  Contact.swift
//  Pods-Runner
//
//  Created by Dmitry Grin on 19.10.2020.
//

import Foundation

struct ContactUnit: Codable {
    var name: String
    var familyName: String
    var imageData: String?
    var phones: [String]
    
    enum CodingKeys: CodingKey {
        case name, familyName, imageData, phones
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(familyName, forKey: .familyName)
        try container.encode(imageData, forKey: .imageData)
        try container.encode(phones, forKey: .phones)
    }
}

struct JsonCodec {
    private static let jsonEncoder = JSONEncoder()
    
    static func encodeToJsonString<T>(_ objectToEncode: T) -> String? where T : Encodable {
        let data = try! jsonEncoder.encode(objectToEncode)
        return String(data: data, encoding: .utf8)
    }
}
