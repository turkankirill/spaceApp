

import SwiftUI

struct ClickableDate: View {
  let date: Date
  var leading = ""
  var trailing = ""

  @State private var isRelative = false

  var body: some View {
    Button(action: { isRelative.toggle() }) {
      if !isRelative {
        Text(date, formatter: dateFormatter)
      } else {
        Text(leading) + Text(date, style: .relative) + Text(trailing)
      }
    }
//	.foregroundColor(.primary)
  }
}

struct ClickableDate_Previews: PreviewProvider {
  static var previews: some View {
    ClickableDate(date: Date(), trailing: " ago")
  }
}
