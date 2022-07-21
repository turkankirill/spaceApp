

import Foundation

var dateFormatter: DateFormatter {
  let df = DateFormatter()
	df.dateStyle = .long
	df.timeStyle = .none
  df.locale = Locale.current

  return df
}
