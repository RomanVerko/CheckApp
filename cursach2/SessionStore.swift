//
//  ЫуыышщтЫещку.swift
//  cursach2
//
//  Created by Роман Верко on 16.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import Firebase
import Combine

class SessionStore: ObservableObject {
    @Published var db = Firestore.firestore()
    @Published var isPresentedPersonalSettings = false
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? {didSet {self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.session = User(uid: user.uid, email: user.email)
            }
            else {
                self.session = nil
            }
        })
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
        
//        self.db.collection("users")
//            .document((Auth.auth().currentUser?.email)!)
//            .setData(["email":email
//        ], merge: true){ err in
//                  if let err = err {
//                      print("Error adding document: \(err)")
//                  } else {
//                    print("Document added with email:\(email)")
//                  }
//
//        }
    }
    
    func signIn(email : String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.session = nil
        }
        catch{
            print("Error signing out")
        }
    }
    
    func unbind(){
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}


struct User {
    var uid: String
    var email: String?
    
    init(uid: String, email: String?){
        self.uid = uid
        self.email = email
    }
}

struct SessionStore_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
