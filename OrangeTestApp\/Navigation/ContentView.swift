


import SwiftUI

struct ContentView: View {
//  #if os(iOS)
//  @Environment(\.horizontalSizeClass) private var horizontalSizeClass
//  #endif

  var body: some View {
//    #if os(iOS)
//    if horizontalSizeClass == .compact {
//      AppTabNavigation()
//    } else {
//      AppSidebarNavigation()
//    }
//    #else
//    AppSidebarNavigation()
//    #endif
	  ZStack {
		  Color.red
			  .ignoresSafeArea()
		  LaunchesView()
	  }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(Store())
  }
}
