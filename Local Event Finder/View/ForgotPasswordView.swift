//
//  ForgotPasswordView.swift
//  Local Event Finder
//
//  Created by Nikhil Varma on 1/13/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var email = ""
    @State private var newPassword = ""
    @State private var errorMessage = ""
    @State private var navigateToLogin = false
    
    var body: some View {
        VStack {
            Text("Reset Password")
                .font(.largeTitle)
                .bold()
                .padding(.top, 50)
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("New Password", text: $newPassword)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: resetPassword) {
                Text("Reset Password")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(errorMessage == "Password reset successful!" ? .green : .red)
                    .bold()
            }
            
            Spacer()
        }
        .padding()
    }
    
    func resetPassword() {
        if UserDefaults.standard.object(forKey: email) != nil {
            UserDefaults.standard.set(newPassword, forKey: email)
            errorMessage = "Password reset successful!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                dismiss()
            }
        } else {
            errorMessage = "User not found"
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
