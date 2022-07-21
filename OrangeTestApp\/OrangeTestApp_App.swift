


import SwiftUI

@main
struct OrangeTestApp_App: App {
	@StateObject private var store = Store()
   @StateObject private var vm = LaunchesViewModel()

 var body: some Scene {
   WindowGroup {
	   NavigationView{
		   
	   LaunchesView()
	   .environmentObject(store)
   }
   }
 }
}
