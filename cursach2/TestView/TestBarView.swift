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


struct TestBarView: View {
    @State var isNavigationBarHidden: Bool = true
    @State var isPresented = true
    
    var body: some View {
        //NavigationView{
            
            
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                   HStack(spacing: 60) {
                       ForEach(1..<10) { num in
                        NavigationLink(destination: PersonalView()){
                           VStack {
                               GeometryReader { geo in
                                   CardView(date: "6 APR", teamName: "Work Comp.", color: Color.purple, pic: "imageReq")
                                   .padding()
                                   .rotation3DEffect(Angle(degrees: (Double(geo.frame(in: .global).minX) - 40) / 20 ), axis: (x:0, y:10.0, z: 0))

                               }.frame(width: 246,height:300)
                           }
                           .frame(width: 190, height:335)
                        }
                       }
                   }
                   .padding(.leading, 56.0)

                }
                
                HStack{
                    Text(" Old ones:")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                List(modelData) { oldOne in
                    NavigationLink(destination: PersonalView()){
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
            

        //}
        
        
        
//        VStack{
//            HStack{
//                Text("New requests:")
//                .font(.title)
//                .fontWeight(.bold)
//
//                Spacer()
//            }
//
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 60) {
//                    ForEach(1..<10) { num in
//                        VStack {
//                            GeometryReader { geo in
//                                CardView(date: "6 APR", teamName: "Work Comp.", color: Color.purple, pic: "imageReq")
//                                .padding()
//                                .rotation3DEffect(Angle(degrees: (Double(geo.frame(in: .global).minX) - 40) / 20 ), axis: (x:0, y:10.0, z: 0))
//
//                            }.frame(width: 246,height:300)
//                        }
//                        .frame(width: 190, height:335)
//                    }
//                }
//
//            }
//
//            HStack{
//                Text("Old ones:")
//                    .font(.title)
//                    .fontWeight(.bold)
//                Spacer()
//            }
//            List(modelData) { oldOne in
//               // NavigationLink(destination: PersonalView()){
//                    HStack {
//                           // 2.
//                           Image(systemName: oldOne.image)
//                               .frame(width: 40, height: 10, alignment: .leading)
//                               .frame(width: 40, height: 10, alignment: .leading)
//                           VStack {
//                               Text(oldOne.city)
//                                   .font(.headline)
//                           }
//                   //    }.font(.title)
//                }
//
//            }
//
//            Spacer()
//        }.padding()
//
//
//
//
    }
}

struct TestBarView_Previews: PreviewProvider {
    static var previews: some View {
        TestBarView()
    }
}
