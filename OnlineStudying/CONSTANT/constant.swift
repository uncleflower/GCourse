import Foundation
import UIKit
import RealmSwift


let COURSE_WEB = "courseWeb"

var headImage = UIImage(systemName: "person.circle")

var users: Results<User>?
var user:User!
var queriedUser = User()

var collections: Results<Course>?
var queriedCollections:Array<Course>!

var defaults = UserDefaults.standard

var statu = Status()
var status:Results<Status>?


//var isLoggedIn = false
//var currentAccount = user.account




