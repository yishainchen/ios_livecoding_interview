/*:
 Let's say we have a struct `Profile` which can represent a user's name with the specific color.

 Now we have an anonymous chat room, when a new user join the chat room, we pick a random name and color
 from a pool for it. Please make a class or func to generate a random `Profile` for a given `UserIdentifier`.

 Limiations:
 1. If the picked name is used, add suffix "_#" to the name. For example: "Apple", "Apple_1", "Apple_2"
 2. Before increment the number in suffix, please make sure all names are used.
 3. An unique user should have the same anonymous `Profile` every time he/her ask for a anonymouse `Profile`
 */
import Foundation
import UIKit

typealias UserIdentifier = String

struct Profile {
    let name: String
    let color: UIColor
}

struct ProfileObjectsPool {
    var namePool = ["Aardvark", "Buffalo", "Cormorant"]
    var colorPool: [UIColor] = [.red, .brown, .cyan, .magenta, .yellow]
    
    func getRandomColor() -> UIColor {
        return colorPool[Int.random(in: 0..<colorPool.count)]
    }
    
    func refillNamePool(userManager: UserManager) -> [String] {
        return namePool.map{ $0 + userManager.getUserNameSuffix() }
    }
}

class UserManager {
    var userList: [String: Profile] = [:]
    var userNameSuffix: Int = 0
    
    func updateUserNameSuffix() {
        userNameSuffix += 1
    }
    
    func getUserNameSuffix() -> String {
        return "_\(userNameSuffix)"
    }
    
    func askAnonymouseProfile(user: String) -> Profile? {
        return userList[user]
    }
}

struct ChatRoom {
    var customNamePool = ProfileObjectsPool().namePool
    var userManager = UserManager()
    
    mutating func joinRoom(userIdentifier: UserIdentifier) {
        guard userManager.userList[userIdentifier] == nil else { return }
        if let name = customNamePool.popLast() {
            userManager.userList[userIdentifier] = Profile(name: name, color: ProfileObjectsPool().getRandomColor())
        } else {
            userManager.updateUserNameSuffix()
            customNamePool = ProfileObjectsPool().refillNamePool(userManager: userManager)
            userManager.userList[userIdentifier] = Profile(name: customNamePool.removeLast(), color: ProfileObjectsPool().getRandomColor())
        }
    }
}

var chatRoom = ChatRoom()
chatRoom.joinRoom(userIdentifier: "user1")
chatRoom.joinRoom(userIdentifier: "user2")
chatRoom.joinRoom(userIdentifier: "user3")
chatRoom.joinRoom(userIdentifier: "user4")
chatRoom.joinRoom(userIdentifier: "user5")
chatRoom.joinRoom(userIdentifier: "user6")
chatRoom.joinRoom(userIdentifier: "user7")

print(chatRoom.userManager.userList)
