//
//  Teammate.swift
//  cursach2
//
//  Created by Роман Верко on 03.05.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import Foundation

struct Teammate: Identifiable
{
    var id = UUID()
    var pic:String
    var name:String
    var role:String
    var email:String=""
  
    
    init(){
        self.id = UUID()
        self.pic = "user"
        self.name = "username"
        self.role = "role"
    }

    init(pic: String, name: String, role: String){
        self.id = UUID()
        self.pic = pic
        self.name = name
        self.role = role
    }
    
    init(pic: String, name: String, role: String, email:String){
        self.id = UUID()
        self.pic = pic
        self.name = name
        self.role = role
        self.email = email
    }
    
    init(mate: Teammate){
        self.id = UUID()
        self.pic = mate.pic
        self.name = mate.name
        self.role = mate.role
    }
    
   
}
