//
//  EventListView.swift
//  Local Event Finder
//
//  Created by Nikhil Varma on 9/24/24.
//

import SwiftUI

struct EventListView: View {
    @State private var showingRegistration = false
    @State private var user = User(id: UUID(), username: "Guest", password: "", interests: [])
    
    let sampleEvents: [Event] = [
        Event(id: UUID(), name: "Sample Event 1", date: Date(), location: "Location 1", description: "Description for Event 1", imageUrl: ""),
        Event(id: UUID(), name: "Sample Event 2", date: Date().addingTimeInterval(86400), location: "Location 2", description: "Description for Event 2", imageUrl: ""),
        Event(id: UUID(), name: "Sample Event 3", date: Date().addingTimeInterval(172800), location: "Location 3", description: "Description for Event 3", imageUrl: ""),
    ]
    
    var body: some View {
        NavigationStack {
            List(sampleEvents) { event in
                NavigationLink(destination: EventDetailView(event: event)) {
                    HStack {
                        Text(event.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                        Text(event.date, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
            }
            .navigationTitle("Events")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing:
                                    Button(action: {
                showingRegistration = true
            }) {
                Image(systemName: "person.circle.fill")
                    .font(.title)
                    .foregroundColor(.blue)
            }
                .fullScreenCover(isPresented: $showingRegistration) {
                    ProfileView(user: user)
                }
            )
        }
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
            .preferredColorScheme(.light)
        EventListView()
            .preferredColorScheme(.dark)
    }
}
