//
//  PersonalView.swift
//  cursach2
//
//  Created by Роман Верко on 18.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

struct PersonalView: View {
    @State var isPushOn = true
    @EnvironmentObject var session: SessionStore
//
//    func getUser(){
//        session.listen()
//    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                CirclePhoto()
                Spacer()
            }.padding(.bottom, 30)
        
            Text("Roman Verko")
                .font(.title)
                .padding(.vertical, 10)
            HStack {
                Text("Higher School of Economics")
                    .font(.subheadline)
                Spacer()
                Text("Project manager")
                    .font(.subheadline)
            }
            Divider().padding()
            
            Toggle(isOn: $isPushOn){
                Text("Push notifications")
            }
            
            Divider().padding()
            HStack{
                Spacer()
                Text("Personal team")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            
            HStack{
                Text("HSE Team inc.")
                    .fontWeight(.semibold)
                Spacer()
                Button(action: {print("action")}){
                    Text("change")
                }
            }.padding()
            Spacer()
            Button(action: session.signOut){
                Text("Sign out")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [.purple,.blue]), startPoint: .leading , endPoint: .trailing))
                .cornerRadius(5)
                
            }.padding(.horizontal, 20)

        }
        .padding(.all, 20)
        .padding(.top, 30)
    }
}

struct PersonalView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalView().environmentObject(SessionStore())
    }
}

