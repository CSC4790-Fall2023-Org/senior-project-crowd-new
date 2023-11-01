//
//  ContentView.swift
//  senior-project-crowd-new
//
//  Created by Gerremy F on 10/27/23.
//

import SwiftUI

struct ContentView: View {
    
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
                    
                    if isLoginMode {
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "person.3.sequence.fill")
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.cyan)
                                //.background(Color.white)
                                .font(.system(size: 94))
                                .padding()
                        }
                        
                    }
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                    
                    //Text("Here is my account creation page")
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Spacer()
                            Text("Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                            Spacer()
                        }.background(Color.cyan)
                    }
                    
                }
                .padding()
                .background(Color(.init(white: 0, alpha: 0.05)))
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(.init(red: 0.2, green: 0.8, blue: 0.8, alpha: 0.4)))
        }
    }
}

#Preview {
    ContentView()
}
