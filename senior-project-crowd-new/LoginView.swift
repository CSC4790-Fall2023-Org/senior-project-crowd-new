//
//  ContentView.swift
//  senior-project-crowd-new
//
//  Created by Gerremy F on 10/27/23.
//

import SwiftUI

struct LoginView: View {
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        
        NavigationView{
            ScrollView {
                VStack(spacing: 16) {
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                        //.padding()
                    
                    if !isLoginMode {
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "person.3.sequence.fill")
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(Color(.init(red: 0.45, green: 0.9, blue: 0.9, alpha: 0.8)))
                                //.background(Color.white)
                                .font(.system(size: 94))
                                .padding()
                        }
                        
                    }
                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                            .autocapitalization(.none)
                    }
                    .padding(11)
                    .background(Color(.init(white: 1, alpha: 0.1)))
                    
                    //Text("Here is my account creation page")
                    
                    Button {
                        handleAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Log In" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }.background(Color(.init(red: 0.45, green: 0.9, blue: 0.9, alpha: 0.8)))
                    }
                    
                }
                .padding()
                .background(Color(.init(white: 0, alpha: 0.03)))
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            //.background(Color(.init(red: 0.95, green: 0.7, blue: 0.65, alpha: 0.5)))
        }
    }
    
    private func handleAction() {
        if isLoginMode {
            print("Should log into Firebase with existing credentials")
        } else {
            print("Register a new acount inside of Firebase Auth and then store image in Storage")
        }
    }
    
}

#Preview {
    LoginView()
}
