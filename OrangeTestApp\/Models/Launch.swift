

import Foundation

struct Launch: Decodable, Identifiable {
  var id: String
  var name: String
  var date_unix: TimeInterval
	let rocket : String
  var details: String?
  var links: Links

  var date: Date {
    Date(timeIntervalSince1970: date_unix)
  }
}

struct Links: Decodable {
  var patch: Flickr
  var youtube_id: String?
  var wikipedia: URL?

  var youtube: URL? {
    if let id = youtube_id {
      return URL(string: "https://youtu.be/\(id)")!
    }
    return nil
  }
}

struct Flickr: Decodable {
  var small: URL?
  var large: URL?
}

