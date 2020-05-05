//
//  TestView.swift
//  cursach2
//
//  Created by Роман Верко on 21.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct TestView: View {
    @State var aim: String = ""
    @State var progress: Double = 5
    @State var progDesc: String = ""
    @State var achivements: String = ""
    @State private var didTap:Bool = false
    @State var prediction: String = ""
    @EnvironmentObject var session: SessionStore
    @Environment(\.presentationMode) var presentationMode
    var mode = ["Module results", "Mental health"]
    var selectorIndex = 0
    let date = Date()
    let formatter = DateFormatter()
    var cardView:CardView
    
   
    init(cardView: CardView){
        self.cardView = cardView
    }
    
    
    var body: some View {
        VStack(spacing: 30){
            Group{
                
            if (self.cardView.type == mode[0]){
                Text("Your aim for this module was")
                    .padding(.top, 30)
                    .font(.headline)
                
                TextField("Work module", text: $aim)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray,
                                                                               lineWidth: 1))
                Divider()
                           
               Text("What have you done:")
                   .font(.headline)
                      

               TextField("Your achivements", text: $achivements)
               .font(.system(size: 14))
               .padding(12)
               .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray,
                                           lineWidth: 1))
            } else {
                Text("How was your mood in this working module?")
                    .padding(.top, 30)
                    .font(.headline)
                
                TextField("My mood was...", text: $aim)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray,
                                                                               lineWidth: 1))
                Divider()
                           
                   Text("What was the reason?")
                       .font(.headline)
                          

                   TextField("some work reasons", text: $achivements)
                   .font(.system(size: 14))
                   .padding(12)
                   .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray,
                                               lineWidth: 1))
            }
               
                Group{
            if progress == 0{
                if self.cardView.type == mode[0]{
                    Text("Did not started 😕")
                } else {
                    Text("I had mental breakdown 🥵")
                }
            }
            else if progress == 1 {
                if self.cardView.type == mode[0]{
                    Text("I have just began 😬")
                }
                else {
                    Text("My mood was disgusting 😤")
                }
            }
            else if progress == 2 {
                if self.cardView.type == mode[0]{
                    Text("Done nearly half 🙂")
                }
                else{
                    Text("It was normal, not bad not good 😐")
                }
            }
            else if progress == 3 {
                if self.cardView.type == mode[0]{
                    Text("Did more than a half 😌")
                } else{
                     Text("I was in good mood 😏")
                }
                
            }
            else if progress == 4 {
                if self.cardView.type == mode[0]{
                    Text("Nearly done 🤓")
                } else {
                    Text("Everything was perfect 😊")
                }
                
                
            }
            else if progress == 5 {
                if self.cardView.type == mode[0]{
                 Text("🎉 I have done everything 😇")
                }
                else {
                    Text("👨🏻‍💻 Best module in my life 🤩")
                }
            }
                }.padding()
                
            }
           
            Slider(value: $progress, in: 0...5, step: 1)
            
            
            Spacer()
            
            if self.cardView.done == false{
                Button(action: {
                    if (self.aim != "" && self.achivements != ""){
                        Firestore.firestore().collection("results")
                            .document(self.cardView.fireID).setData([
                                "aim":self.aim,
                                "achievements":self.achivements,
                                "progress":self.progress,
                                "done":true,
                                "dateDone": Date()
                                ], merge: true)
                            { err in
                                if let err = err {
                                    print("Error adding document: \(err)")
                                } else {
                                    print("Document added with ID: \(self.cardView.fireID)")
                                }
                        }
                        
                        self.didTap = true
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                    
                }){
                    Text(didTap ? "Done!" : "Submit")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .background(LinearGradient(gradient: Gradient(colors: [.purple,.blue]), startPoint: .leading , endPoint: .trailing))
                        .cornerRadius(5)
                    
                }.padding(.horizontal, 40)
                    .padding(.bottom, 35)
            }
            
             
            
        }.navigationBarTitle(self.cardView.name)
        .padding()
        
        
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(cardView: CardView(date: Date(), name: "Everyday check", type: "Mental health", desc: "Daily",
                                    email: "rmimamov@edu.hse.ru", done: false, fireID: "0101010101"))
    }
}
