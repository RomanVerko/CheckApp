//
//  TestBarView.swift
//  cursach2
//
//  Created by Роман Верко on 19.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

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
    var cards:[CardView]=[CardView(date: "6 APR", teamName: "Work Comp.", color: Color.blue, pic: "photo"),
     CardView(date: "8 APR", teamName: "HSE Inc.", color: Color.red, pic: "square.and.pencil"),
     CardView(date: "9 MAR", teamName: "ART sc.", color: Color.green, pic: "checkmark"),
     CardView(date: "12 MAR", teamName: "HSE.", color: Color.purple, pic: "text.badge.checkmark"),
     CardView(date: "15 FEB", teamName: "Work Comp.", color: Color.orange, pic: "square.and.pencil")]
    
    var body: some View {
            
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                   HStack(spacing: 60) {
                       ForEach(cards) { card in
                        NavigationLink(destination: TestView()){
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
                   .padding(.leading, 56.0)
                   
                }.padding(.top, 10)
              
                
                HStack{
                    Text(" Old ones:")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                List(modelData) { oldOne in
                    NavigationLink(destination: TestView()){
                        HStack {
                               // 2.
                               Image(systemName: oldOne.image)
                                   .frame(width: 40, height: 10, alignment: .leading)
                                   .frame(width: 40, height: 10, alignment: .leading)
                               VStack {
                                   Text(oldOne.city)
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
