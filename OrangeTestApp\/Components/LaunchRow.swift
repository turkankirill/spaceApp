


import KingfisherSwiftUI
import SwiftUI

struct LaunchRow: View {
  let launch: Launch

  
  let padding: CGFloat = 30
 

  var body: some View {
    NavigationLink(destination: LaunchDetailView(launch: launch)) {
      VStack {
        // Patch
		  HStack {
        if let patch = launch.links.patch.small {
          KFImage(patch)
            .resizable()
            .frame(width: 100, height: 100)
        } else {
          Image(systemName: "paperplane")
            .frame(width: 100, height: 100)
        }
		  }
		  .frame(minWidth: UIScreen.main.bounds.width - 30)
		  .frame(height: 150)
		  .overlay(
				 RoundedRectangle(cornerRadius: 16)
					 .stroke(.white, lineWidth: 1)
			 )
        // Text
        VStack {
			HStack{
			Text(launch.name)
					.foregroundColor(Color("Label"))
				Spacer()
          Text(launch.date, formatter: dateFormatter)
            .font(.subheadline)
			.foregroundColor(Color.white)
			.padding(4)
			.background(Color.gray)
			}
			
        }
      }.padding(.vertical, padding)
    }
  }
}

//struct LaunchRow_Previews: PreviewProvider {
//  static var previews: some View {
//    Group {
//      LaunchRow(launch: testLaunches[0])
//        .preferredColorScheme(.light)
////      LaunchRow(launch: testLaunches[1])
////        .preferredColorScheme(.light)
//    }.previewLayout(.sizeThatFits)
//  }
//}
