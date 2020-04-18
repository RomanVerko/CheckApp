//
//  TabView.swift
//  cursach2
//
//  Created by Роман Верко on 18.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

struct TabbedView: View {
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        TabView{
            PersonalView().tabItem({
                Image(systemName: "person.icloud.fill")
                    .font(.title)
                Text("Account")
                }).tag(0)
        
            TestBarView().tabItem({
            Image(systemName: "message.fill")
                .font(.title)
            Text("Requests")
            }).tag(1)
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView()
    }
}
