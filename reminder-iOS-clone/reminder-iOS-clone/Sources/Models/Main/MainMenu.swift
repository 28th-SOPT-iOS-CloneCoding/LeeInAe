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
        menuList = [Group(title: GroupType.todo, todos: [], isSelect: true), Group(title: GroupType.today, todos: [], isSelect: true), Group(title: GroupType.flag, todos: [], isSelect: true), Group(title: GroupType.forMe, todos: [], isSelect: true), Group(title: GroupType.total, todos: [], isSelect: true)]
        totalTodos = []
    }
}
