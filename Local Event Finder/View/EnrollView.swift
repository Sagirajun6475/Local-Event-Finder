//
//  EnrollView.swift
//  Local Event Finder
//
//  Created by Nikhil Varma on 2/13/25.
//

import SwiftUI

struct EnrollView: View {
    let event: Event
    @State private var numberOfAttendees = 1
    @State private var attendeeNames: [String] = [""]
    @State private var showConfirmation = false
    @State private var showIncompleteDetailsAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Enroll for \(event.name)")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 20)
                
                Stepper("Number of attendees: \(numberOfAttendees)", value: $numberOfAttendees, in: 1...10, onEditingChanged: { _ in
                    adjustAttendeeList()
                })
                .padding(.bottom, 10)
                
                ForEach(0..<numberOfAttendees, id: \.self) { index in
                    TextField("Attendee \(index + 1) Name", text: Binding(
                        get: { index < attendeeNames.count ? attendeeNames[index] : "" },
                        set: { if index < attendeeNames.count { attendeeNames[index] = $0 } }
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 5)
                }
                
                Spacer()
                
                Button(action: {
                    if validateAttendees() {
                        showConfirmation = true // Show confirmation if all fields are filled
                    } else {
                        showIncompleteDetailsAlert = true // Show alert if not all fields are filled
                    }
                }) {
                    Text("Confirm Enrollment")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .alert(isPresented: $showConfirmation) {
                    Alert(title: Text("Enrollment Successful"),
                          message: Text("You have successfully enrolled \(numberOfAttendees) people for \(event.name)."),
                          dismissButton: .default(Text("OK")))
                }
                .alert(isPresented: $showIncompleteDetailsAlert) {
                    Alert(title: Text("Incomplete Details"),
                          message: Text("Please fill in all attendee names before confirming enrollment."),
                          dismissButton: .default(Text("OK")))
                }
            }
            .padding()
        }
        .navigationTitle("Enroll")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func adjustAttendeeList() {
        if numberOfAttendees > attendeeNames.count {
            attendeeNames.append(contentsOf: Array(repeating: "", count: numberOfAttendees - attendeeNames.count))
        } else if numberOfAttendees < attendeeNames.count {
            attendeeNames = Array(attendeeNames.prefix(numberOfAttendees))
        }
    }
    
    private func validateAttendees() -> Bool {
        for name in attendeeNames {
            if name.isEmpty {
                return false
            }
        }
        return true
    }
}

struct EnrollView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleEvent = Event(
            id: UUID(),
            name: "Sample Event",
            date: Date(),
            location: "Sample Location",
            description: "This is a sample description for the event.",
            imageUrl: ""
        )
        
        Group {
            EnrollView(event: sampleEvent)
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")
                .padding()
            
            EnrollView(event: sampleEvent)
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
                .padding()
        }
    }
}
