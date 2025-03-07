//
//  EventViewModel.swift
//  Local Event Finder
//
//  Created by Nikhil Varma on 9/24/24.
//

import Foundation

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    
    // Dummy data for demonstration purposes
    func loadEvents() {
        events = [
            Event(id: UUID(), name: "Food Festival", date: Date(), location: "City Park", description: "A festival celebrating local cuisine.", imageUrl: ""),
            Event(id: UUID(), name: "Music Concert", date: Date().addingTimeInterval(86400), location: "Downtown Arena", description: "Live music from various artists.", imageUrl: ""),
            // Add more events as needed
        ]
    }
}

