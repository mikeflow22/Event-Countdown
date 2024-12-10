//
//  EventRow.swift
//  Event Countdown
//
//  Created by M F on 11/30/24.
//

import SwiftUI

struct EventRow: View {
    @State var currentTime: Date = Date()
    var relativeDate: String {
	  let timeInterval = event.date.timeIntervalSince(currentTime)
	  if timeInterval <= 0 {
		return "Event has started!"
	  } else {
		let months = Int(timeInterval) / (60 * 60 * 24 * 30)
		let days = Int(timeInterval) / (60 * 60 * 24)
		let hours = (Int(timeInterval) % (60 * 60 * 24)) / (60 * 60)
		let mins = Int(timeInterval) % (60 * 60) / 60
		let seconds = Int(timeInterval) % 60
		var components: [String] = []
		if months > 0 { components.append("\(months)m") }
		if days > 0 { components.append("\(days)d") }
		if hours > 0 { components.append("\(hours)h") }
		if mins > 0 { components.append("\(mins)m") }
		if seconds > 0 { components.append("\(seconds)s") }
		
		return components.joined(separator: ", ")
	  }
    }
    let event: Event
    let mockDate: Date = Date().addingTimeInterval(8888888)
    
    var body: some View {
	  HStack {
		VStack(alignment: .leading) {
		    Text(event.title)
			  .foregroundColor(event.textColor)
			  .font(.headline)
			  .bold()
		    Text(event.date.formatted(date: .numeric, time: .shortened))
		    Text(relativeDate)
		}
		.padding()
		Spacer()
		Button {
		    
		} label: {
		    Image(systemName: "chevron.right")
			  .font(.body)
			  .foregroundColor(.gray)
		}

	  }
	  .onAppear() {
		Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
		    Task { @MainActor in
			  self.currentTime = Date()
		    }
		}
	  }
    }
    
}

#Preview {
    EventRow(event: Event(title: "Test", date: Date.now, textColor: .cyan))
}
/*

 
 */
