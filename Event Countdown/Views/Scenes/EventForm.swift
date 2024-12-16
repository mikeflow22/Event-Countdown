    //
    //  EventForm.swift
    //  Event Countdown
    //
    //  Created by M F on 11/30/24.
    //

import SwiftUI

struct EventForm: View {
    @State private var date: Date = Date()
    @State private var textColor: Color = Color.black
    @State private var title = ""
    @State private var navigationTitle: String = ""
    
    public var mode: Mode
    public var event: Event?
    public var onSave: (Event) -> Void //this passes the vent back to the parent view
    
    var body: some View {
	  NavigationStack {
		Form {
		    Section {
			  TextField("Event Title", text: $title)
				.foregroundColor(textColor)
			  DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
			  ColorPicker("Text Color", selection: $textColor)
		    }
		}
		.toolbar {
		    ToolbarItem(placement: .topBarTrailing) {
			  Button {
				save()
			  } label: {
				Image(systemName: "checkmark")
			  }
		    }
		}
		
		
		.navigationTitle(navigationTitle)
		.navigationBarTitleDisplayMode(.inline)
	  }
	  .onAppear {
		if mode == .edit {
		    guard let event = event else { return }
		    title = event.title
		    date = event.date
		    textColor = event.textColor
		    navigationTitle = "Edit \(title)"
		} else if mode == .add {
		    navigationTitle = "Add Event"
		    
		}
		print("Event: \(String(describing: event))")
	  }
    }
    
    func save() {
	  if validateTitle() {
		switch mode {
		case .add:
		    let newEvent = Event(title: title, date: date, textColor: textColor)
		    onSave(newEvent) //passes this back to eventsView
		case .edit:
		    if var existingEvent = event {
			  existingEvent.title = title
			  existingEvent.date = date
			  existingEvent.textColor = textColor
			  onSave(existingEvent) // passes this back to eventsView
		    }
		case .none:
		    break
		}
	  }
    }
    
    func validateTitle() -> Bool {
	  if title.isEmpty {
		return false
	  } else {
		return true
	  }
    }
}

#Preview {
    NavigationStack {
	  EventForm(mode: .add, event: nil, onSave: {_ in })
    }
}
