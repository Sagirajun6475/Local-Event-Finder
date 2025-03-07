//
//  SignUpView.swift
//  Local Event Finder
//
//  Created by Nikhil Varma on 1/13/25.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var signUpSuccess = false
    @State private var errorMessage = ""
    @State private var navigateToEvents = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                Spacer()
                
                VStack(spacing: 15) {
                    TextField("Email (Username)", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: signUp) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                    
                    if signUpSuccess {
                        Text("Sign Up Successful!")
                            .foregroundColor(.green)
                            .padding(.top, 10)
                    }
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .ignoresSafeArea(edges: .top)
            .navigationDestination(isPresented: $navigateToEvents) {
                EventListView()
            }
        }
    }
    
    func signUp() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password are required"
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }
        
        UserDefaults.standard.set(password, forKey: email)
        signUpSuccess = true
        errorMessage = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            navigateToEvents = true
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
