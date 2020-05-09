//
//  PersonalSettings.swift
//  cursach2
//
//  Created by Роман Верко on 02.05.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI
import Firebase

struct PersonalSettings: View {
    var person: Teammate 
    @State var name:String = ""
    @State var role:String = ""
    @EnvironmentObject var session: SessionStore
    @Environment(\.presentationMode) var presentationMode
    
    init(person : Teammate){
        self.person = person
        self.name = person.name
        self.role = person.role
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Image(person.pic)
        .resizable()
        .clipShape(Circle())
        .overlay(
            Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 10)
            .aspectRatio(contentMode: .fit)
            .frame(width: 150)
        .padding(.top, 10)
        
            Text("Name").padding(.top, 20)
                  .font(.headline)
            
            TextField("\(person.name)", text: $name)
              .font(.system(size: 14))
              .padding(12)
              .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray,
                                          lineWidth: 1))
              
              Text("Team role").padding(.top, 5)
              .font(.headline)
              
            TextField("\(person.role)", text: $role)
                         .font(.system(size: 14))
                         .padding(12)
                         .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray,
                                                     lineWidth: 1))
            Spacer()
            
            Button(action: {
                if (self.name != "" && self.role != ""){
                    self.session.db.collection("users")
                        .document((Auth.auth().currentUser?.email)!)
                    .setData(["name":self.name,
                              "role":self.role,
                              "email": (Auth.auth().currentUser?.email)!
                    ], merge: true){ err in
                              if let err = err {
                                  print("Error adding document: \(err)")
                              } else {
                                print("Document added with ID: \(self.self.name.lowercased().trimmingCharacters(in: .whitespaces))")
                              }
                                    
                    }
                    self.session.isPresentedPersonalSettings = false
                }
            }){
                Text("Submit")
                .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [.purple ,.blue]), startPoint: .leading , endPoint: .trailing))
                .cornerRadius(5)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 35)
        }.padding(.horizontal)
        .navigationBarTitle("Edit personal data")
    }
}

struct PersonalSettings_Previews: PreviewProvider {
    static var previews: some View {
        PersonalSettings(person: Teammate())
         .environmentObject(SessionStore())
    }
}
