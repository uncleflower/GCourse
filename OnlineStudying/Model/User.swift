import UIKit

struct User {
    var load = false
    var userName: String
    var account: Int
    var password: String
    var headPortrait = UIImage()
    var collections = [CourseCollection]()
}

var user = User(
    load: false,
    userName: "登录/注册",
    account: 123456,
    password: "123456",
    headPortrait: UIImage(systemName: "person.circle")!,
    collections: [
        CourseCollection(courseName: "mooc", courseImage: UIImage(systemName: "sun.min")!, courseSchool: "家里蹲", url: "https://www.icourse163.org"),
        CourseCollection(courseName: "bilibili", courseImage: UIImage(systemName: "moon")!, courseSchool: "家里蹲", url: "https://www.bilibili.com"),
        CourseCollection(courseName: "baidu", courseImage: UIImage(systemName: "cloud.drizzle.fill")!, courseSchool: "家里蹲", url: "https://www.baidu.com")
    ]
)

