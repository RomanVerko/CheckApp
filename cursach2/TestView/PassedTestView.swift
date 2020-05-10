//
//  PassedTestView.swift
//  cursach2
//
//  Created by Роман Верко on 05.05.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI
import Firebase

struct passedData{
    var date = ""
    var name:String = ""
    var type:String = ""
    var desc:String = ""
    var email: String = ""
    var done: Bool = true
    var aim = ""
    var progress = 0.0
    var achievements = ""
    var dateDone = ""
    
    init(){
        
    }
    
}

struct PassedTestView: View {
//    var date: Date = Date()
    var name:String = ""
//    var type:String = ""
//    var desc:String = ""
//    var email: String = ""
//    var done: Bool = true
    var fireID:String = ""
    let formatter = DateFormatter()
//    var aim = ""
//    var progress = 0.0
//    var achievements = ""
//    var dateDone = Date()
    
    @ObservedObject var checkoutData = observer(fireID: "")
    
    class observer: ObservableObject{
                 
        @Published var doneCheckout = passedData()
                
        init(fireID:String){
           Firestore.firestore().collection("results").document(fireID).getDocument{ snap, err in
                if err != nil{
                    return
                }
                let data = (snap!.data())!
            self.doneCheckout.achievements = data["achievements"] as? String ?? "no data"
            }
        }
    }
    
    
    init(cardView: CardView){
        self.fireID = cardView.fireID
        self.name = cardView.name
        self.checkoutData = observer(fireID: self.fireID)
        self.formatter.dateFormat = "dd.MM.yyyy"
    }
    
    var body: some View {
        VStack {
            Text(checkoutData.doneCheckout.achievements)
        }.navigationBarTitle(self.name)
    }
}

struct PassedTestView_Previews: PreviewProvider {
    static var previews: some View {
        PassedTestView(cardView: CardView(date: "", name: "name", type: "Module results", desc: "desc", email: "email", done: true, fireID: "01010"))
    }
}
