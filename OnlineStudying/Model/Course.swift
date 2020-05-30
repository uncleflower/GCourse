//
//  Collection.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/3/6.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import UIKit
import RealmSwift

class Course:Object {
    @objc dynamic var account = 123456
    @objc dynamic var courseName = ""
    @objc dynamic var url = ""
    @objc dynamic var createdAT = Date()
}

//struct CourseCollection {
//    var courseName: String
//    var url: String
//}

