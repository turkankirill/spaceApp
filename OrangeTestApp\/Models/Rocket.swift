//
import Foundation

struct Rocket : Codable {
	let payload_weights : [PayloadWeights]?
	let name : String?
	let id : String

	enum CodingKeys: String, CodingKey {
		case payload_weights = "payload_weights"
		case name = "name"
		case id = "id"
	}
}

struct PayloadWeights : Codable {
	let kg : Int?

	enum CodingKeys: String, CodingKey {
		case kg = "kg"
	}
}
