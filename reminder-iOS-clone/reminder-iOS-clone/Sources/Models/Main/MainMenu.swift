//
//  MainMenu .swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/20.
//

import Foundation

class MainMenu {
    static let mainMenu = MainMenu()

    var menuList: [Group]
    var totalTodos: [Todo]

    init() {
        menuList = [Group(title: GroupType.todo.rawValue, todos: [], isSelect: true), Group(title: GroupType.today.rawValue, todos: [], isSelect: true), Group(title: GroupType.flag.rawValue, todos: [], isSelect: true), Group(title: GroupType.forMe.rawValue, todos: [], isSelect: true), Group(title: GroupType.total.rawValue, todos: [], isSelect: true)]
        totalTodos = []
    }
}
