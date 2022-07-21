


import KingfisherSwiftUI
import SwiftUI
import YouTubePlayerKit

struct LaunchDetailView: View {
	@EnvironmentObject var vm: LaunchesViewModel
  let launch: Launch
  var youtubePlayer: YouTubePlayer?
  
  let listStyle = GroupedListStyle()


	
	init(launch: Launch) {
		self.launch = launch
		
		if let youtube_id = launch.links.youtube_id {
			youtubePlayer = YouTubePlayer(
				source: .video(id: youtube_id),
				configuration: .init(autoPlay: false)
			)
		}
	}
	
  var body: some View {
//			  .ignoresSafeArea()
	  VStack {
		  Spacer()
			  .frame(height: 30)
		  youtube
//      if let patch = launch.links.patch.large {
//        Section(header: HStack {
//          Spacer()
//          KFImage(patch)
//            .placeholder { ProgressView() }
//            .resizable()
//            .frame(width: 270, height: 270)
//            .shadow(color: .secondary, radius: 5)
//            .padding()
//            .padding(.top)
//          Spacer()
//        }) {}
//      }

		  ScrollView {
        if launch.date > Date() {
          ClickableDate(date: launch.date, leading: "In ")
				.opacity(0.5)
        } else {
          ClickableDate(date: launch.date, trailing: " ago")
				.opacity(0.5)
        }



      // Details
      
			  Text(launch.details ?? "None")
				  .multilineTextAlignment(.center)
			  .padding()
			  .opacity(0.7)
			  
		  
		  if let wikipedia = launch.links.wikipedia {
					Link("Wikipedia", destination: wikipedia)
					  .foregroundColor(Color("Label"))
				  }
			  
//			  Text("Rocket Name: \(vm.rocket?.name ?? "unknown")")
			  
//			  Text("Payload Mass: \(vm.rocket?.payload_weights?.first?.kg ?? 0) kg")

		  
		  Spacer()
		  }
    }
	  .navigationBarTitleDisplayMode(.inline)
	  .navigationBarTitle(launch.name)
	  .foregroundColor(.white)
	  .background(Color("BG").edgesIgnoringSafeArea(.bottom))
	  .onAppear {
		  vm.getRocket(rocketId: launch.rocket)
	  }
  }
}

//struct LaunchDetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    NavigationView {
//      LaunchDetailView(launch: testLaunches[0])
//    }
//  }
//}

extension LaunchDetailView {
	private var youtube: some View {
		ZStack {
			if let youtubePlayer = youtubePlayer {
				YouTubePlayerView(youtubePlayer)
					.scaledToFit()
			} else {
				VStack {
					Text("Eror \nPlease try again later")
						.font(.footnote)
						.multilineTextAlignment(.center)
				}
				.foregroundColor(Color.white)
				.padding(.vertical, 80)
			}
		}
		.frame(maxWidth: .infinity)
		.background(Color.black)
	}
}
