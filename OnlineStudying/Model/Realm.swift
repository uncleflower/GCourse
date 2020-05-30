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



