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
    let date: String
    let teamName:String
    let color: Color
    let pic: String
    @State var isPresented = false
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(color)
                .frame(width: 220, height: 300, alignment: .center)
                .cornerRadius(20)
                .shadow(radius: 5)
                
        
            VStack{
                HStack(alignment: .center){
                    Text(date).padding()
                    Text("MON")
                }
                .foregroundColor(Color.white)
                .font(.system(size: 32, weight: .semibold))
                Image(systemName: pic)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 110)
                    .offset(y: -20)
                    .foregroundColor(.white)
                
                Text(teamName)
                .foregroundColor(Color.white)
                    .font(.system(size: 32, weight: .light))
                .offset(y: -10)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            CardView(date: "7 MAR", teamName: "HSE Inc.", color: Color.red, pic: "photo")
            CardView(date: "6 APR", teamName: "Work Comp.", color: Color.gray, pic: "checkmark")
        }
        
    }
}
