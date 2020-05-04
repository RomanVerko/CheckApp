//
//  PersonalView.swift
//  cursach2
//
//  Created by Роман Верко on 18.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import Combine
import Firebase

struct PersonalView: View {
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var userData:observer = observer()
    
    
    class observer: ObservableObject{
        
        @Published var userData = Teammate()
         var user = Auth.auth().currentUser
        
        init(){

            Firestore.firestore().collection("users").document((user?.email)!)
                .addSnapshotListener{ (snap, err) in
                    if err != nil {
                        print((err?.localizedDescription)!)
                        return
                    }
                    self.userData = Teammate()
                    Firestore.firestore().clearPersistence { (err) in
                    print((err?.localizedDescription)!)
                    }
                    guard let i = snap!.data()
                        else {print("Houston, we have a problems...")
                            return
                    }
                   let mate =  Teammate(pic: i["pic"] as? String ?? "user",
                                                          name: i["name"] as? String ?? "defaultname",
                                                          role: i["role"] as? String ?? "defaultrole",
                                                          email: i["email"] as? String ?? "defaultemail",
                                                          isActive: i["isActive"] as? Bool ?? true)
                self.userData = mate
            }
           
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                CirclePhoto(pic: userData.userData.pic)
                Spacer()
            }.padding(.bottom, 30)
        
            Text(userData.userData.name)
                .font(.title)
                .padding(.vertical, 10)
            HStack {
                Text(userData.userData.role)
                    .font(.subheadline)
                Spacer()
                Button(action: {
                    self.session.isPresentedPersonalSettings = true
                }){
                Text("edit")
                    .sheet(isPresented: $session.isPresentedPersonalSettings){
                        PersonalSettings(person: self.userData.userData)
                                    .environmentObject(self.session)
                    }
                }
            }
            Divider().padding()
            
            HStack{
                if userData.userData.isActive == true{
                    Text("Active member")
                } else {
                    Text("Notifications disabled")
                }
                Spacer()
                Button(action: {
                    self.userData.userData.isActive.toggle()
                    Firestore.firestore().collection("users").document((self.userData.user?.email)!)
                    .setData(["isActive" : self.userData.userData.isActive], merge: true)
                }){
                    if userData.userData.isActive == true{
                        Text("Disable")
                    } else {
                        Text("Enable")
                    }
                }
                
            }
            
            Divider().padding()
            HStack{
                Spacer()
                Text("Personal team")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            Group{
            HStack{
                Text("HSE Team inc.")
                    .fontWeight(.semibold)
                Spacer()
                Button(action: {print("action")}){
                    Text("change")
                }
            }.padding()
            
            
                
            }
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

