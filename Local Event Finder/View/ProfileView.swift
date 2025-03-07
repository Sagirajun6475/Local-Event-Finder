//
//  ProfileView.swift
//  Local Event Finder
//
//  Created by Nikhil Varma on 9/25/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State var user: User
    let enrolledEvents: [Event] = [
        Event(id: UUID(), name: "Sample Event 1", date: Date(), location: "Location 1", description: "Description for Event 1", imageUrl: ""),
        Event(id: UUID(), name: "Sample Event 2", date: Date().addingTimeInterval(86400), location: "Location 2", description: "Description for Event 2", imageUrl: "")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                        Text("Events")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.leading, -10)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Username")
                    .font(.headline)
                Text(user.username)
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Interests")
                    .font(.headline)
                WrapView(data: user.interests) { interest in
                    Text(interest)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.blue.opacity(0.2))
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                        .font(.subheadline)
                }
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Enrolled Events")
                    .font(.headline)
                // Displaying the enrolled events list
                List(enrolledEvents) { event in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(event.name)
                                .font(.headline)
                            Text(event.date, style: .date)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            Spacer ()
            
            Button(action: editEvents) {
                Text("Edit Events")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func editEvents() {
        print("Button Pressed")
    }
}

struct WrapView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let content: (Data.Element) -> Content
    
    @State private var totalHeight = CGFloat.zero
    
    init(data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.content = content
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }
    
    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(Array(self.data), id: \.self) { item in
                self.content(item)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > geometry.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if item == self.data.last! {
                            width = 0 // Last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        if item == self.data.last! {
                            height = 0 // Last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: HeightPreferenceKey.self, value: geometry.size.height)
        }
        .onPreferenceChange(HeightPreferenceKey.self) { binding.wrappedValue = $0 }
    }
}

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleUser = User(id: UUID(), username: "SampleUser", password: "password", interests: ["Music", "Food", "Workshops"])
        ProfileView(user: sampleUser)
    }
}
