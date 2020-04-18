//
//  TestBarView.swift
//  cursach2
//
//  Created by Роман Верко on 19.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

struct TestBarView: View {
    
    var body: some View {
        VStack{
            HStack{
                Text("New requests:")
                .font(.title)
                
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(1..<10) { num in
                        VStack {
                            GeometryReader { geo in
                                CardView(date: "6 APR", teamName: "Work Comp.", color: Color.purple, pic: "imageReq")
                                .padding()
                                .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).minX) / 8), axis: (x: 0, y: 1, z: 0))
                            }.frame(width: 246,height:300)
                        }
                        .frame(width: 180)
                    }
                }
                .padding()
            }
            HStack{
                Text("Old ones:")
                .font(.title)
                
                Spacer()
            }
            Spacer()
            
            }
        
    .padding()
    }
}

struct TestBarView_Previews: PreviewProvider {
    static var previews: some View {
        TestBarView()
    }
}
