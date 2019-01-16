//
//  Item.swift
//  Todoey
//
//  Created by Ice on 15/1/2562 BE.
//  Copyright © 2562 Ice. All rights reserved.
//

import Foundation

//class  Item : Encodable,Decodable{

//Encodable,Decodable -> Codable

class  Item : Codable{
    var title : String = ""
    var done : Bool = false
}
