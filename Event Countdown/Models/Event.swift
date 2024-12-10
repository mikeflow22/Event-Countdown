//
//  Event.swift
//  Event Countdown
//
//  Created by M F on 11/30/24.
//

import Foundation
import SwiftUI

struct Event: Identifiable, Hashable {
    let id: UUID = UUID()
    var title: String
    var date: Date
    var textColor: Color
}

extension Event: Comparable {
    static func < (lhs: Event, rhs: Event) -> Bool {
	  if lhs.date < rhs.date {
		return true
	  } else {
		return false
	  }
    }
}

extension Event {
    static var all: [Event] = [
	  Event(title: "First Event", date: Date().addingTimeInterval(111111), textColor: .blue),
	  Event(title: "Second Event", date: Date().addingTimeInterval(222222), textColor: .red),
	  Event(title: "Third Event", date: Date().addingTimeInterval(4444444), textColor: .green),
	  Event(title: "Fourth Event", date: Date().addingTimeInterval(6666666), textColor: .orange),
	  Event(title: "Fifth Event", date: Date().addingTimeInterval(8888888), textColor: .yellow)
	  
	  ]
}
