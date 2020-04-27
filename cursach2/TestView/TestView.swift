//
//  TestView.swift
//  cursach2
//
//  Created by Роман Верко on 21.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

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
    
    static var aimTest:String = ""//some very very very long description string to be initially wider than screen"
    static var aimtestBinding = Binding<String>(get: { aimTest }, set: {
    //        print("New value: \($0)")
            aimTest = $0 } )
    
    static var done:String = ""//some very very very long description string to be initially wider than screen"
    static var doneBinding = Binding<String>(get: { done }, set: {
    //        print("New value: \($0)")
            done = $0 } )
    
    static var notDone:String = ""//some very very very long description string to be initially wider than screen"
    static var notDoneBinding = Binding<String>(get: { notDone }, set: {
    //        print("New value: \($0)")
            notDone = $0 } )
    
    
    var body: some View {
        VStack(spacing: 30){
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
            
        
            Group{
            
            if progress == 0{
                Text("Did not started 😕")
               
            }
            else if progress == 1 {
                Text("I have just began 😬")
                 
            }
            else if progress == 2 {
                Text("Done nearly half 🙂")
                
            }
            else if progress == 3 {
                Text("Did more than a half 😌")
                             }
            else if progress == 4 {
                Text("Nearly done 🤓")
                
            }
            else if progress == 5 {
                Text("🎉 I have done everything 😇")
                 
            }
            }.padding(.bottom, -15)
           
            Slider(value: $progress, in: 0...5, step: 1)
            
        
            Group{
            Text("Describe results of this working part")
                .font(.body)
        
        
                Text("\(prediction)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
           
                
            
            Button(action: {
                self.formatter.dateFormat = "MM-dd-yyyy"
                if (self.aim != "" && self.achivements != ""){
                    if self.selectorIndex == 0{
                        self.session.db.collection("Answers").document((self.session.session?.email)!).collection(self.mode[self.selectorIndex])
                        .document(self.formatter.string(from: Date()))
                        .setData(["aim":self.aim,
                                  "desc:":self.achivements,
                                  "progress":self.progress], merge: true){ err in
                                  if let err = err {
                                      print("Error adding document: \(err)")
                                  } else {
                                    print("Document added with ID: \(self.aim)")
                                  }
                        }
                    } else {
                        //todo mood
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
             
            
        }.navigationBarTitle("Write your progress")
        .padding()
        
        
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
