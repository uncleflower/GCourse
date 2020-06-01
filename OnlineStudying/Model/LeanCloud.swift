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


func LCQueryCourse(account:Int){
    
    let query = LCQuery(className: "Course")
    query.whereKey("account", .equalTo(account))
    _ = query.find { result in
        switch result {
        case .success(objects: let courses):
            
            collections = realm.objects(Course.self).filter("account = \(status![0].currentAccount)")
            
            guard collections?.count == 0 else {
                return
            }
            for i in 0 ..< courses.count {
                
                let queryCourse = LCQuery(className: "Course")
                let _ = queryCourse.get(courses[i].objectId!) { (result) in
                    switch result {
                    case .success(object: let course):
                        
                        let LCCourse = Course()
                        
                        LCCourse.account = course.get("account")!.intValue!
                        LCCourse.courseName = course.get("courseName")!.stringValue!
                        LCCourse.url = course.get("url")!.stringValue!
                        LCCourse.createdAT = course.get("createdAT")!.dateValue!
                        
                        saveCourse(course: LCCourse)
                        
                    case .failure(error: let error):
                        print(error)
                    }
                }
            }
            
            break
        case .failure(error: let error):
            print(error)
        }
    }
}

func LCQueryUser(account:Int) -> Int {
    
    let query = LCQuery(className: "MyUser")
    query.whereKey("account", .equalTo(account))

    _ = query.getFirst { result in
        switch result {
        case .success(object: let user):

            print("1")
            let queryUser = LCQuery(className: "MyUser")
            let _ = queryUser.get(user.objectId!) { (result) in
                switch result {
                case .success(object: let user):
                    
                    let isAccountExist = realm.objects(User.self).filter("account = \(account)")
                    
                    if isAccountExist.count == 0 {
                        let LCUser = User()
                        
                        LCUser.account = user.get("account")!.intValue!
                        LCUser.password = user.get("password")!.stringValue!
                        LCUser.userName = user.get("username")!.stringValue!
                        
                        saveUser(user: LCUser)
                    }
                                            
                case .failure(error: let error):
                    print(error)
                }
            }

        case .failure(error: let error):
            print("2")
            print(error)
        }
    }
    
    let count = query.count().intValue
    
    return count
}

func LCQueryUser(account:Int, password:String) -> Int {
    
    let query = LCQuery(className: "MyUser")
    query.whereKey("account", .equalTo(account))
    query.whereKey("password", .equalTo(password))

    _ = query.getFirst { result in
        switch result {
        case .success(object: let user):

            print("1")
            let queryUser = LCQuery(className: "MyUser")
            let _ = queryUser.get(user.objectId!) { (result) in
                switch result {
                case .success(object: let user):
                    
                    let isAccountExist = realm.objects(User.self).filter("account = \(account)")
                    
                    if isAccountExist.count == 0 {
                        let LCUser = User()
                        
                        LCUser.account = user.get("account")!.intValue!
                        LCUser.password = user.get("password")!.stringValue!
                        LCUser.userName = user.get("username")!.stringValue!
                        
                        saveUser(user: LCUser)
                    }
                                            
                case .failure(error: let error):
                    print(error)
                }
            }

        case .failure(error: let error):
            print("2")
            print(error)
        }
    }
    
    let count = query.count().intValue
    
    return count
}



