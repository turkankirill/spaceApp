

import SwiftUI

struct AppSidebarNavigation: View {
  @State private var selection: Set<NavigationItem> = [.launches]

  var body: some View {
    NavigationView {
      sidebar
      Text("Content List")
      Text("Select Item")
    }
  }

  var sidebar: some View {
    List(selection: $selection) {
      NavigationLink(destination: LaunchesView()) {
        Label("Launches", systemImage: "paperplane")
          .tag(NavigationItem.launches)
      }

      #if os(iOS)
      NavigationLink(destination: SearchView()) {
        Label("Search", systemImage: "magnifyingglass")
          .tag(NavigationItem.search)
      }
      #endif
    }
    .listStyle(SidebarListStyle())
    .navigationTitle("SpaceX")
  }

  enum NavigationItem {
    case launches
    case search
  }
}

struct AppSidebarNavigation_Previews: PreviewProvider {
  static var previews: some View {
    AppSidebarNavigation()
      .environmentObject(Store())
  }
}
