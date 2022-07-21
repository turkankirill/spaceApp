


import Combine
import Foundation

class LaunchesViewModel: ObservableObject {
	var launchSubscription: AnyCancellable?
	@Published var rocket: Rocket?
	@Published var loadingError = Bool()
	
	func getRocket(rocketId: String) {
		guard let url = URL(string: "https://api.spacexdata.com/v4/rockets/\(rocketId)") else { return }
		
		launchSubscription = NetworkingManager.download(url: url)
			.decode(type: Rocket.self, decoder: JSONDecoder())
		//			.sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedRocket in
		//				self?.rocket = returnedRocket
		//				self?.launchSubscription?.cancel()
		//			})
			.sink(receiveCompletion: { completion in
				switch completion {
				case .finished: break
				case .failure(let error):
					self.loadingError = true
					print(error.localizedDescription)
				}
			}, receiveValue: { [ weak self] returnedRocket in
				self?.rocket = returnedRocket
				self?.launchSubscription?.cancel()
				self?.loadingError = false
			})
	}
}
class NetworkingManager {
	enum NetworkingError: LocalizedError {
		case badURLResponse(url: URL)
		case unknown
		
		var errorDescription: String? {
			switch self {
			case .badURLResponse(let url): return "NetworkingManager: Bad response from URL. \(url)"
			case .unknown: return "NetworkingManager: Unknown error occured"
			}
		}
	}
	
	static func download(url: URL) -> AnyPublisher<Data, Error> {
		URLSession.shared.dataTaskPublisher(for: url)
			.subscribe(on: DispatchQueue.global(qos: .default))
			.tryMap({ try handleURLResponse(output: $0, url: url) })
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
	
	static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
		guard let response = output.response as? HTTPURLResponse,
			  response.statusCode >= 200 && response.statusCode < 300 else {
			throw NetworkingError.badURLResponse(url: url)
		}
		
		return output.data
	}
	
	static func handleCompletion(completion: Subscribers.Completion<Error>) {
		switch completion {
		case .finished:
			return
		case .failure(let error):
			print(error.localizedDescription)
		}
	}
}

