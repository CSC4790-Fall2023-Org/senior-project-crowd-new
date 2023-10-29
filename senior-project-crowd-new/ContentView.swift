//
//  ContentView.swift
//  senior-project-crowd-new
//
//  Created by Gerremy F on 10/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        /*
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Let's build out our login page!")
        }
        .padding()
        */
        NavigationView{
            ScrollView {
                Text("Here is my account creation page")
            }
        }
        Text("Lets build out our login page")
            .padding()
    }
}

#Preview {
    ContentView()
}
