//
//  RegistrationView.swift
//  Local Event Finder
//
//  Created by Nikhil Varma on 9/24/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var interests: String = ""
    @State private var availableInterests: [String] = ["Music", "Food", "Workshops", "Travel", "Sports", "Art", "Technology"]
    @State private var selectedInterests: [String] = []
    @State private var showError: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Create an Account")) {
                    TextField("Username", text: $username)
                    SecureField("Password", text: $password)
                    TextField("Interests", text: $interests)
                        .padding(.bottom, 10)
                        .disabled(true)
                        
                    VStack(alignment: .leading){
                        Text("Select Atleast 3")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10){
                                ForEach(availableInterests, id: \.self) { interest in
                                    Button(action: {addInterest(interest)
                                    }) {
                                        Text(interest)
                                            .padding()
                                            .background(Color.blue.opacity(0.2))
                                            .cornerRadius(8)
                                            .foregroundColor(.blue)
                                            .font(.subheadline)
                                    }
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    //                    if !selectedInterests.isEmpty {
                    //                        Text("Selected Interests: \(selectedInterests.joined(separator: ", "))")
                    //                            .font(.subheadline)
                    //                    }
                }
                if showError {
                    Text("Please select at least 3 interests to proceed.")
                        .foregroundColor(.red)
                        .font(.footnote)
                        .padding(.top, 5)
                }
                
                Button(action: registerUser) {
                    Text("Register")
                }
            }
            .navigationTitle("Register")
        }
    }
    
    private func addInterest(_ interest: String) {
        if !interests.contains(interest) {
            if !interests.isEmpty {
                interests += ", "
            }
            interests += interest
            availableInterests.removeAll { $0.caseInsensitiveCompare(interest) == .orderedSame }
        } else {
            selectedInterests.removeAll { $0 == interest }
        }
    }
    
    private func registerUser() {
        let userInterests = interests.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        
        for interest in userInterests {
            availableInterests.removeAll { $0.caseInsensitiveCompare(interest) == .orderedSame }
        }
        
        let newUser = User(id: UUID(), username: username, password: password, interests: userInterests)
        
        print("User registered: \(newUser)")
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
