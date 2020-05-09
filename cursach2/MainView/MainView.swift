//
//  TestBarView.swift
//  cursach2
//
//  Created by Роман Верко on 19.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import Combine
import FirebaseAuth

struct OldOnes: Identifiable {
    var id = UUID()
    var image: String
    var city: String
}

let modelData: [OldOnes] =
[OldOnes(image: "square.and.pencil", city: "HSE"),
OldOnes(image: "checkmark",  city: "Work Corp"),
OldOnes(image: "text.badge.checkmark", city: "Income test"),
OldOnes(image: "square.and.pencil", city: "Code review")]


struct MainView: View {
    @State var isNavigationBarHidden: Bool = true
    @State var isPresented = true
    
    @ObservedObject var checkoutData = observer()
    
    var checkouts: [CardView] = []

       
       class observer: ObservableObject{
               
            @Published var UndoneCheckouts = [CardView]()
            @Published var DoneChekouts = [CardView]()
              
              init(){
                let db = Firestore.firestore().collection("results").whereField("email", isEqualTo: (Auth.auth().currentUser?.email)!)
                  
                  db.addSnapshotListener{ (snap, err) in
                       
                      if err != nil{
                          print((err?.localizedDescription)!)
                          return
                      }
                    
                      self.UndoneCheckouts = [CardView]()
                      self.DoneChekouts = [CardView]()
                    
                      Firestore.firestore().clearPersistence { (err) in
                          print((err?.localizedDescription)!)
                      }
                      for i in snap!.documents {
                          print((i["name"] as? String ?? "default name"))
                          print((i["desc"] as? String ?? "default description"))
                        let check = CardView(date: i["date"] as? Date ?? Date(),
                                             name: i["name"] as? String ?? "default name",
                                             type: i["type"] as? String ?? "default type",
                                             desc: i["desc"] as? String ?? "default description",
                                             email: i["email"] as? String ?? "default email",
                                             done: i["done"] as? Bool ?? true,
                                             fireID: i.documentID)
                        if check.done == false{
                            self.UndoneCheckouts.append(check)
                        }
                        else{
                            self.DoneChekouts.append(check)
                        }
                       self.UndoneCheckouts.sort(by: { $0.date > $1.date })
                       self.DoneChekouts.sort(by: { $0.date > $1.date })
                      }
                    if self.UndoneCheckouts.count == 0 {
                        self.UndoneCheckouts.append(CardView(date: Date(), name: "Nothing new!", type: "none", desc: "you're up to date", email: "", done: false, fireID: ""))
                    }
                  }
                
              }
              
          }
       
    
    
    var body: some View {
            
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                   HStack(spacing: 60) {
                    ForEach(self.checkoutData.UndoneCheckouts) { card in
                        NavigationLink(destination: TestView(cardView: card)){
                           VStack {
                               GeometryReader { geo in
                                    card 
                                   .padding()
                                   .rotation3DEffect(Angle(degrees: (Double(geo.frame(in: .global).minX) - 40) / 20 ), axis: (x:0, y:10.0, z: 0))

                               }.frame(width: 246,height:350)
                           }
                           .frame(width: 190, height:335)
                        }
                       }
                   }
                   .padding(.leading, 75.0)
                   
                }.padding(.top, 10)
              
                
                HStack{
                    Text(" Old ones:")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                List() {
                    ForEach(self.checkoutData.DoneChekouts){ oldOne in
                            HStack {
                                Image(systemName: oldOne.pic)
                                    .frame(width: 40, height: 10, alignment: .leading)
                                    .frame(width: 40, height: 10, alignment: .leading)
                                VStack {
                                    Text(oldOne.name)
                                        .font(.headline)
                                }
                            }.font(.title)
                    }
                }
            
            } .padding(.horizontal, 5)
         .navigationBarTitle("New requests")
            
    }
}

struct TestBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
