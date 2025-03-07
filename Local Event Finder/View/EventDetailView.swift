//
//  EventDetailView.swift
//  Local Event Finder
//
//  Created by Nikhil Varma on 9/24/24.
//

import SwiftUI

struct EventDetailView: View {
    let event:Event
    
    var body: some View {
        
        ScrollView{
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.top)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer().frame(height: 20)
                
                
                HStack{
                    Text(event.date, style: .date)
                        .font(.title3)
                        .foregroundColor(.primary)
                        .padding(.leading)
                    
                    Spacer()
                    
                    Text(event.date, style: .time)
                        .font(.title3)
                        .foregroundColor(.primary)
                        .padding(.trailing)
                }
                .padding(.vertical)
                
                Spacer()
                Divider()
                    .background(Color.primary)
                    .padding(.horizontal)
                
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(Color.primary)
                    Text(event.location)
                        .font(.title2)
                        .foregroundColor(Color.primary)
                }
                .padding(.horizontal)
                
                Divider()
                    .background(Color.primary)
                    .padding(.horizontal)
                
                Text(event.description)
                    .foregroundColor(.primary)
                    .padding()
                
                Spacer()
                
                NavigationLink(destination: EnrollView(event: event)) {
                    Text("Enroll")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Event Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let sampleEvent = Event(id: UUID(), name: "Sample Event", date: Date(), location: "Sample Location", description: "This is a sample description for the event.", imageUrl: "")
        
        EventDetailView(event: sampleEvent)
            .preferredColorScheme(.light)
        EventDetailView(event: sampleEvent)
            .preferredColorScheme(.dark) 
    }
}
