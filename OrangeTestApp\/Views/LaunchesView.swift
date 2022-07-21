


import SwiftUI

struct LaunchesView: View {
  @EnvironmentObject private var store: Store

  let listStyle = PlainListStyle()
 

  var body: some View {
    if store.upcomingLaunches.isEmpty || store.pastLaunches.isEmpty {
      ProgressView()
        .navigationTitle("SpaceX")
        .onAppear { store.fetchUpcomingLaunches() }
        .onAppear { store.fetchPastLaunches() }
    } else {
      list
        .navigationTitle("SpaceX")
    }
  }

  var list: some View {
//    let n1 = store.upcomingLaunches.count
//    let n2 = store.pastLaunches.count
//	  ZStack {
//		  Color("BG")
//			  .ignoresSafeArea()
		  ScrollView{
		  ForEach(store.upcomingLaunches) { launch in
					LaunchRow(launch: launch)
				  }
					  ForEach(store.pastLaunches.reversed()) { launch in
						LaunchRow(launch: launch)
					  }
			  
		  }
		  .padding(.horizontal)
		  .background(Color("BG").edgesIgnoringSafeArea(.bottom))
//	  }
	  
//    return List {
//      Section() {
//        ForEach(store.upcomingLaunches) { launch in
//          LaunchRow(launch: launch)
//        }
//      }
//
//      Section() {
//        ForEach(store.pastLaunches.reversed()) { launch in
//          LaunchRow(launch: launch)
//        }
//      }
//    }

//	.listStyle(listStyle)
  }

  struct Header: View {
    let text: String
    let n: Int

    var body: some View {
      HStack {
        Text(text)
        Spacer()
        Text("\(n)")
      }
    }
  }
}

struct LaunchesView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      LaunchesView()
        .environmentObject(Store())
    }
  }
}
