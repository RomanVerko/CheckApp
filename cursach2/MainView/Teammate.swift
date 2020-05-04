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
    var isActive: Bool
  
    
    init(){
        self.id = UUID()
        self.pic = "user"
        self.name = "username"
        self.role = "role"
        self.isActive = true
    }

    init(pic: String, name: String, role: String, isActive: Bool){
        self.id = UUID()
        self.pic = pic
        self.name = name
        self.role = role
        self.isActive = isActive
        
    }
    
    init(pic: String, name: String, role: String, email:String, isActive: Bool){
        self.id = UUID()
        self.pic = pic
        self.name = name
        self.role = role
        self.email = email
        self.isActive = isActive
    }
    
    init(mate: Teammate){
        self.id = UUID()
        self.pic = mate.pic
        self.name = mate.name
        self.role = mate.role
        self.isActive = mate.isActive
    }
    
   
}
