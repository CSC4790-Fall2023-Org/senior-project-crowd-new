//
//  ContentView.swift
//  senior-project-crowd-new
//
//  Created by Gerremy F on 10/27/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLoginMode = false
    
    var body: some View {
        NavigationView{
            ScrollView {
                
                Picker(selection: $isLoginMode, label: Text("Picker here")) {
                    Text("Login")
                        .tag(true)
                    Text("Create Account")
                        .tag(false)
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                
                Text("Here is my account creation page")
            }
            .navigationTitle("Create Account")
        }
    }
}

#Preview {
    ContentView()
}
