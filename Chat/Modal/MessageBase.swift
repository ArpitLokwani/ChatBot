//
//  MessageBase.swift
//  ChatBot
//
//  Created by ArpitLokwani on 19/01/21.
//  Copyright © 2021 iOS Revisited. All rights reserved.
//

import Foundation
struct MessageBase : Codable {
    let success : Int?
    let errorMessage : String?
    let message : Message?
    let data : [String]?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case errorMessage = "errorMessage"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Int.self, forKey: .success)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        message = try values.decodeIfPresent(Message.self, forKey: .message)
        data = try values.decodeIfPresent([String].self, forKey: .data)
    }

}
