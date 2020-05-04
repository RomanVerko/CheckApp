//
//  CardView.swift
//  cursach2
//
//  Created by Роман Верко on 19.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

struct CardView: Identifiable, View{
    var id = UUID()
    var date: Date
    var teamName:String = ""
    var colorFirst: Color
    var colorSecond: Color
    var pic: String
    @State var isPresented = false
    var type: String
    var name: String
    var fireID:String
    var desc: String
    var email: String
    var done:Bool
    let formatter = DateFormatter()
    
    init(date: Date, name: String,type: String, desc:String, email: String, done: Bool, fireID: String){
        self.date = date
        self.name = name
        self.type = type
        self.desc = desc
        self.email = email
        self.done = done
        self.fireID = fireID
        if type == "Module results"{
            colorFirst = .blueFirst
            colorSecond = .blueSecond
            pic = "text.badge.checkmark"
        } else {
            colorFirst = .purpleFirst
            colorSecond = .purpleSecond
            pic = "person.crop.circle.badge.checkmark"
        }
        self.formatter.dateFormat = "dd.MM.yyyy"
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(LinearGradient(
                    gradient: .init(colors: [colorFirst, colorSecond]),
                    startPoint: .init(x: 0.5, y: 0.1),
                  endPoint: .init(x: 0.5, y: 0.8)
                ))
                .frame(width: 220, height: 300, alignment: .center)
                .cornerRadius(20)
                .shadow(radius: 5)
                
        
            VStack{
                HStack(alignment: .center){
                    Text(self.name)
                }
                .foregroundColor(Color.white)
                .font(.system(size: 25, weight: .semibold))
                Image(systemName: pic)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .foregroundColor(.myGray)
                    .padding()
                    
                
                Text(self.desc)
                .foregroundColor(Color.white)
                    .font(.system(size: 20, weight: .light))
                    
                
                Text(self.formatter.string(from: Date()))
                .foregroundColor(Color.white)
                    .font(.system(size: 20, weight: .light))
                    .padding(.top)
            }
        }
    }
}
extension Color {
    static let purpleFirst = Color("purpleFirst")
    static let purpleSecond = Color("purpleSecond")
    static let blueFirst = Color("blueFirst")
    static let blueSecond = Color("blueSecond")
    static let myGray = Color("myGray")
}
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            CardView(date: Date(), name: "name", type: "Module results", desc: "desc", email: "email", done: true, fireID: "01010")
            CardView(date: Date(), name: "name2", type: "Mental health", desc: "desc2", email: "email2", done: true, fireID: "01010")
        }

    }
}
