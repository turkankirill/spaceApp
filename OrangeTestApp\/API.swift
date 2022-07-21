


import Combine
import Foundation

class API {
  private static let baseURL = "https://api.spacexdata.com/v4"

  static func makeURL(with endpoint: Endpoint) -> URL {
    URL(string: baseURL + endpoint.path())!
  }

  static func fetch<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, NetworkError> {
    let request = URLRequest(url: API.makeURL(with: endpoint))

    return URLSession.shared.dataTaskPublisher(for: request)
      .tryMap(NetworkError.processResponse)
      .decode(type: T.self, decoder: JSONDecoder())
      .mapError {
        print($0)
        return NetworkError.parseError(error: $0)
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}

enum Endpoint {
  case upcomingLaunches
  case pastLaunches


  func path() -> String {
    switch self {
      case .upcomingLaunches: return "/launches/upcoming"
      case .pastLaunches: return "/launches/past"
	

    }
  }
}

enum NetworkError: Error {
  case statusCode(code: Int)
  case parseError(error: Error)
  case unknown

  static func processResponse(data: Data, response: URLResponse) throws -> Data {
    guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.unknown }

    switch httpResponse.statusCode {
      case 200 ... 299: return data
      case let code: throw NetworkError.statusCode(code: code)
    }
  }
}


