    //
    //  EventsView.swift
    //  Event Countdown
    //
    //  Created by M F on 11/30/24.
    //

import SwiftUI

enum Mode {
    case add
    case edit
    case none
}

struct EventsView: View {
    @State var mockEvents: [Event] = Event.all
    @State private var mode: Mode = .none
    @State private var isPresented: Bool = false //presenting the eventForm View
    @State private var selectedEvent: Event?
    
    var body: some View {
	  NavigationStack {
		List(mockEvents) { event in
			  EventRow(event: event)
			  .contentShape(Rectangle())
			  .onTapGesture {
				Task { @MainActor in
				    mode = .edit
				    isPresented = true
				    selectedEvent = event
				}
			  }
		    .swipeActions(edge: .trailing) {
			  Button(role: .destructive) {
				delete(event)
			  } label: {
				Label("Delete", systemImage: "trash")
			  }
		    }
		}
		.toolbar {
		    ToolbarItem(placement: .topBarTrailing) {
			  Button {
				Task { @MainActor in
				    mode = .add
				    isPresented = true
				}
			  } label: {
				Image(systemName: "plus")
			  }
		    }
		}
		.navigationTitle("Events")
		.navigationDestination(isPresented: $isPresented) {
		    EventForm(mode: mode, event: selectedEvent, onSave: saveEvent)
		}
	  }
    }
    
    func delete(_ event: Event) {
	  if let index = mockEvents.firstIndex(where: { $0.id == event.id} ) {
		Task { @MainActor in
		    mockEvents.remove(at: index)
		}
	  }
    }
    
    func saveEvent(_ event: Event) {
	  Task { @MainActor in
		switch mode {
		case .add:
		    mockEvents.append(event)
		case .edit:
		    if let index = mockEvents.firstIndex(where: {$0.id == event.id }) {
			  mockEvents[index] = event
		    }
		case .none:
		    break
		}
		isPresented = false //we are navigating from the childview to the parent view
	  }
    }
    
}

#Preview {
    NavigationStack {
	  EventsView()
    }
}
