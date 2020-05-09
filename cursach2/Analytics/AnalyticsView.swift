//
//  AnalyticsView.swift
//  cursach2
//
//  Created by Роман Верко on 19.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI
import Firebase

struct AnalyticsView: View {
    var teammate: Teammate
        @ObservedObject var results:observer = observer(teammate: Teammate())
          
       init(mate: Teammate){
              teammate = mate
              results = observer(teammate: mate)
       }
          
       
       class observer: ObservableObject{
                  
           @Published var checkNames = [String]()
           @Published var uniqNames = Array<String>()
                 
              init(teammate: Teammate){
                     let db = Firestore.firestore().collection("results")
                        .whereField("email", isEqualTo: (Auth.auth().currentUser?.email)!)
                     
                       db.addSnapshotListener{ (snap, err) in
                          
                         if err != nil{
                             print((err?.localizedDescription)!)
                             return
                         }
                         Firestore.firestore().clearPersistence { (err) in
                             print((err?.localizedDescription)!)
                         }
                       
                       for i in snap!.documents {
                           self.checkNames.append(i["name"] as? String ?? "no data srtring")
                           
                       }
                       
                       self.uniqNames = Array(Set(self.checkNames))
                     }
               }
                 
       }
       
       
       
       var body: some View {
           VStack{
               VStack{
                   Text("Your checkpoints")
                       .font(.largeTitle)
                Text((Auth.auth().currentUser?.email)!)
                   if self.results.uniqNames.count == 0{
                       Spacer()
                       Text("You do not have any completed checkpoints")
                       .font(.system(size: 17, weight: .light))
                       Spacer()
                   }
               }.padding(.top, -45)
               Spacer()
               if self.results.uniqNames.count != 0{
                   List(self.results.uniqNames, id: \.self){ uniq in
                       NavigationLink(destination: GraphicsView(mate: self.teammate, uniq: uniq)){ 
                           Text(uniq)
                       }
                   }.padding(.top, 20)
               }
           }.padding(.horizontal, 10)
           
       }
       
      
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView(mate: Teammate())
    }
}
