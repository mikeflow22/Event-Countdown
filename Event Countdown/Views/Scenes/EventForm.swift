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
    
    public var mode: Mode
    public var event: Event?
    public var onSave: (Event) -> Void //this passes the vent back to the parent view
    private var navigationTitle: String  {
	  if let eventTitle = event?.title {
		print(eventTitle)
		return eventTitle
	  } else {
		return "Add Event"
	  }
    }
    
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
		}
		print("Event: \(String(describing: event))")
	  }
	  .onDisappear {
		    //		mode = .none
		    //		event = nil
	  }
    }
    
    func save() {
	  if validateTitle() {
		switch mode {
		case .add:
		    let newEvent = Event(title: title, date: date, textColor: textColor)
		    onSave(newEvent)
		case .edit:
		    if var existingEvent = event {
			  existingEvent.title = title
			  existingEvent.date = date
			  existingEvent.textColor = textColor
			  onSave(existingEvent)
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
