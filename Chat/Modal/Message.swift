
//  ChatBot
//
//  Created by Arpit Lokwani on 19/01/21.
//  Copyright © 2021 Arpit Lokwani. All rights reserved.

import Foundation
struct Message : Codable {
	let chatBotName : String?
	let chatBotID : Int?
	let message : String?
	let emotion : String?

	enum CodingKeys: String, CodingKey {

		case chatBotName = "chatBotName"
		case chatBotID = "chatBotID"
		case message = "message"
		case emotion = "emotion"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		chatBotName = try values.decodeIfPresent(String.self, forKey: .chatBotName)
		chatBotID = try values.decodeIfPresent(Int.self, forKey: .chatBotID)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		emotion = try values.decodeIfPresent(String.self, forKey: .emotion)
	}

}
