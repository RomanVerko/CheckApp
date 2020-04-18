//
//  CardView.swift
//  cursach2
//
//  Created by Роман Верко on 19.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

struct CardView: View{
    let date: String
    let teamName:String
    let color: Color
    let pic: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [color,Color.blue]), startPoint: .bottom, endPoint: .topLeading))
                .frame(width: 220, height: 300, alignment: .center)
            .cornerRadius(20)
            
            VStack{
                HStack(alignment: .center){
                    Text(date).padding()
                    Text("MON")
                }
                .foregroundColor(Color.white)
                .font(.system(size: 32, weight: .semibold))
                Image(pic)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140)
                    .shadow(color: Color.white, radius: 2)
                    .offset(y: -20)
                
                if pic == "testReq"{
                    Text("some test requests")
                        .font(.caption)
                        .foregroundColor(.white)
                    .offset(y: -30)
                } else {
                    Text("work photo requests")
                       .font(.caption)
                       .foregroundColor(.white)
                   .offset(y: -30)
                }
                
                
                Text(teamName)
                .foregroundColor(Color.white)
                .font(.system(size: 32, weight: .semibold))
                .offset(y: -10)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            CardView(date: "7 MAR", teamName: "HSE Inc.", color: Color.red, pic: "testReq")
            CardView(date: "6 APR", teamName: "Work Comp.", color: Color.gray, pic: "imageReq")
        }
        
    }
}
