//
//  ContentView.swift
//  cursach2
//
//  Created by Роман Верко on 16.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    
    
    func getUser(){
        session.listen()
    }
    
    var body: some View {
        Group {
            if (session.session != nil){
                Text("Welcome back user!")
                Button(action: session.signOut){
                    Text("Sign Out")
                }
            } else {
                AuthView()
            }
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}
