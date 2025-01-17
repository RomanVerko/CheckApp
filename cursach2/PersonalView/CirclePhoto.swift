//
//  CirclePhoto.swift
//  cursach2
//
//  Created by Роман Верко on 18.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

struct CirclePhoto: View {
    var pic:String
    
    init(pic: String){
        self.pic = pic
    }
    
    var body: some View {
        Image(pic)
        .resizable()
        .clipShape(Circle())
        .overlay(
            Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 10)
            .aspectRatio(contentMode: .fit)
            .frame(width: 170)
    }
}

struct CirclePhoto_Previews: PreviewProvider {
    static var previews: some View {
        CirclePhoto(pic: "avatar")
    }
}
