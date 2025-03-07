//
//  LoginView.swift
//  Local Event Finder
//
//  Created by Nikhil Varma on 1/13/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var loginSuccess = false
    @State private var showForgotPassword = false
    @State private var navigateToEvents = false
    
    var body: some View {
        NavigationStack{
            VStack {

                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                Spacer()
                
                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: login) {
                        Text("Login")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                    
                    if loginSuccess {
                        Text("Login Successful!")
                            .foregroundColor(.green)
                            .padding(.top, 10)
                    }
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    Button(action: {
                        showForgotPassword = true
                    }) {
                        Text("Forgot Password?")
                            .foregroundColor(.blue)
                            .padding(.top, 8)
                    }
                    .sheet(isPresented: $showForgotPassword) {
                        ForgotPasswordView()
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
    
    func login() {
        guard let storedPassword = UserDefaults.standard.string(forKey: email) else {
            errorMessage = "User not found"
            return
        }
        
        if storedPassword == password {
            loginSuccess = true
            errorMessage = ""
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                navigateToEvents = true
            }
        }
        else {
            errorMessage = "Incorrect password"
            loginSuccess = false
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
