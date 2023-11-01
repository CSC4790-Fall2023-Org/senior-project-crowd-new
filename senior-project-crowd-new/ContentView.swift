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
                
                VStack {
                    
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                        //.padding()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "person.3.sequence.fill")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.mint)
                            //.foregroundStyle(.primary)
                            //.foregroundStyle(.white, .orange, .blue)\
                            /*
                            .foregroundStyle(
                                .linearGradient(
                                    colors: [.pink, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
                             */
                            .font(.system(size: 94))
                            .padding()
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
                        }.background(Color.teal)
                    }
                    
                }
                .padding()
            }
            .navigationTitle("Create Account")
        }
    }
}

#Preview {
    ContentView()
}
