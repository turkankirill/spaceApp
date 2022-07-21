


import Combine
import Foundation

class Store: ObservableObject {
  @Published private(set) var upcomingLaunches = [Launch]()
  @Published private(set) var pastLaunches = [Launch]()
  


  func searchAll(query: String) -> (
    upcomingLaunches: [Launch],
    pastLaunches: [Launch]

  ) {
    let q = query.lowercased()

    return (
      upcomingLaunches.filter { $0.name.lowercased().contains(q) },
      pastLaunches.filter { $0.name.lowercased().contains(q) }
    )
  }

  // MARK: -

  private var disposables = Set<AnyCancellable>()

  func fetchUpcomingLaunches() {
    guard upcomingLaunches.isEmpty else { return }

    API.fetch(endpoint: .upcomingLaunches)
      .sink(receiveCompletion: { print($0) }, receiveValue: { self.upcomingLaunches = $0 })
      .store(in: &disposables)
  }

  func fetchPastLaunches() {
    guard pastLaunches.isEmpty else { return }

    API.fetch(endpoint: .pastLaunches)
      .sink(receiveCompletion: { print($0) }, receiveValue: { self.pastLaunches = $0 })
      .store(in: &disposables)
  }
	
	
}
