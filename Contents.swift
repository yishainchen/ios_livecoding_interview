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

var namePool = ["Aardvark", "Buffalo", "Cormorant"]
var customBaseName = namePool
var colorPool: [UIColor] = [.red, .brown, .cyan, .magenta, .yellow]

struct Profile {
    let name: String
    let color: UIColor
}

var chatRoom: [String: Profile] = [:]

var users: [UserIdentifier] = ["user1", "user2", "user3", "user4", "user1"]

var count: Int = 0

for user in users where chatRoom[user] == nil {
    if let name = customBaseName.popLast() {
        chatRoom[user] = Profile(name: name, color: colorPool.first!)
    } else {
        count += 1
        customBaseName = namePool.map{ $0 + "_\(count)" }
        chatRoom[user] = Profile(name: customBaseName.removeLast(), color: colorPool[Int.random(in: 0..<colorPool.count - 1)])
    }
}

print(chatRoom)

