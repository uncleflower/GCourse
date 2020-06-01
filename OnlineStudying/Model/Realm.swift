import Foundation
import RealmSwift

let realm = try! Realm()

func saveCourse(course:Course) {
    do {
        try realm.write {
            realm.add(course)
        }
    } catch {
        print(error)
    }
}

func deleteCourse(course:Course) {
    do {
        try realm.write {
            realm.delete(course)
        }
    } catch {
        print(error)
    }
}

func saveUser(user:User) {
    do {
        try realm.write {
            realm.add(user)
        }
    } catch {
        print(error)
    }
}

func saveStatus(status:Status) {
    do {
        try realm.write {
            realm.add(status)
        }
    } catch {
        print(error)
    }
}

func updateCourseName(row:Int,name:String) {
    do {
        try realm.write {
            collections![row].courseName = name
            LCUpdateCourseName(row: row, name: name)
        }
    } catch {
        print(error)
    }
}

func updatePassword(user:User,newPassword:String) {
    do {
        try realm.write {
            user.password = newPassword
            LCUpdatePassword(user: user, newPassword: newPassword)
        }
    } catch {
        print(error)
    }
}



