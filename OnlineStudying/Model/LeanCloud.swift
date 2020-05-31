//
//  LeanCloud.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/5/31.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import Foundation
import LeanCloud
import SwiftyJSON

func creatConnection() {
    do {
        try LCApplication.default.set(
            id: "KYkjEN75Efcx6eryiQnYTusO-gzGzoHsz",
            key: "aVW9ifHoemPucDu3UWY8GD0W",
            serverURL: "https://kykjen75.lc-cn-n1-shared.com"
        )
    } catch {
        print(error)
    }
}

func LCSaveUser(LCUser:User) {
    do {
        // 构建对象
        let user = LCObject(className: "MyUser")

        // 为属性赋值
        try user.set("username", value: LCUser.userName)
        try user.set("account", value: LCUser.account)
        try user.set("password", value: LCUser.password)

        // 将对象保存到云端
        _ = user.save { result in
            switch result {
            case .success:
                // 成功保存之后，执行其他逻辑
                break
            case .failure(error: let error):
                // 异常处理
                print(error)
            }
        }
    } catch {
        print(error)
    }
}

func LCSaveCourse(LCCourse:Course) {
    do {
        // 构建对象
        let collection = LCObject(className: "Course")

        // 为属性赋值
        try collection.set("account", value: LCCourse.account)
        try collection.set("courseName", value: LCCourse.courseName)
        try collection.set("url", value: LCCourse.url)
        try collection.set("createdAT", value: LCCourse.createdAT)

        // 将对象保存到云端
        _ = collection.save { result in
            switch result {
            case .success:
                // 成功保存之后，执行其他逻辑
                break
            case .failure(error: let error):
                // 异常处理
                print(error)
            }
        }
    } catch {
        print(error)
    }
}

//查：
func LCQueryUser(account:Int){
    let query = LCQuery(className: "MyUser")
    query.whereKey("account", .equalTo(account))

    query.whereKey("account", .selected)
    query.whereKey("password", .selected)
    query.whereKey("username", .selected)
    _ = query.getFirst { result in
        switch result {
        case .success(object: let user):

            print("1")
            print(user.jsonValue)

            queriedUser.account = user.get("account")!.intValue!
            queriedUser.password = user.get("password")!.stringValue!
            queriedUser.userName = user.get("username")!.stringValue!

//            let json = JSON(user)
//            queriedUser.account = json["account"].intValue
//            queriedUser.password = json["passowrod"].stringValue
//            queriedUser.userName = json["username"].stringValue

            print(queriedUser.account)

        case .failure(error: let error):
            print("2")
            print(error)
        }
    }
}



func LCQueryCourse(account:Int) -> Array<LCObject>{
    
    let query = LCQuery(className: "Course")
    var res = Array<LCObject>()
    query.whereKey("account", .equalTo(account))
    _ = query.find { result in
        switch result {
        case .success(objects: let courses):
            // students 是包含满足条件的 Student 对象的数组
            res = courses
            break
        case .failure(error: let error):
            print(error)
        }
    }
    return res
}

func LCDeleteCourse(course: Course) {
    
    let query = LCQuery(className: "Course")
    query.whereKey("createdAT", .equalTo(course.createdAT))
    _ = query.find { result in
        switch result {
        case .success(objects: let courses):
            
            let course = LCObject(className: "Course", objectId: courses[0].objectId!)
            _ = course.delete{ result in
                switch result {
                case .success:
                    break
                case .failure(error: let error):
                    print(error)
                }
            }
            break
        case .failure(error: let error):
            print(error)
        }
    }
}

func LCUpdateCourseName(row:Int,name:String) {
    
    let query = LCQuery(className: "Course")
    query.whereKey("createdAT", .equalTo(collections![row].createdAT))
    _ = query.find { result in
        switch result {
        case .success(objects: let courses):
            
            do {
                let course = LCObject(className: "Course", objectId: courses[0].objectId!)
                try course.set("courseName", value: name)
                course.save { (result) in
                    switch result {
                    case .success:
                        break
                    case .failure(error: let error):
                        print(error)
                    }
                }
            } catch {
                print(error)
            }
            break
        case .failure(error: let error):
            print(error)
        }
    }
}

func LCUpdatePassword(user:User,newPassword:String) {
    let query = LCQuery(className: "MyUser")
    query.whereKey("account", .equalTo(user.account))
    _ = query.find { result in
        switch result {
        case .success(objects: let users):
            
            do {
                let user = LCObject(className: "MyUser", objectId: users[0].objectId!)
                try user.set("password", value: newPassword)
                user.save { (result) in
                    switch result {
                    case .success:
                        break
                    case .failure(error: let error):
                        print(error)
                    }
                }
            } catch {
                print(error)
            }
            break
        case .failure(error: let error):
            print(error)
        }
    }
}






