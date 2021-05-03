//
//  MainMenu .swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/20.
//

import Foundation

class MainMenu {
    static let mainMenu = MainMenu()

    var totalGroups: [Group] {
        didSet {
            customGroups = totalGroups.filter { $0.type == GroupType.custom }
        }
    }

    var totalTodos: [Todo]
    var customGroups: [Group]

    init() {
        totalGroups = [Group(type: GroupType.todo, todos: [], isSelect: true), Group(type: GroupType.today, todos: [], isSelect: true), Group(type: GroupType.flag, todos: [], isSelect: true), Group(type: GroupType.forMe, todos: [], isSelect: true), Group(type: GroupType.total, todos: [], isSelect: true), Group(type: GroupType.custom, title: "웅앵.", icon: "😁", color: .red, todos: [Todo(title: "애옹", memo: "누누", url: "url", flag: false)]), Group(type: GroupType.custom, title: "내일 할 일", icon: "✨", color: .blue, todos: [Todo(title: "우웅", memo: "낼 해야할", url: "url", flag: true)], isSelect: false)]
        totalTodos = []
        customGroups = totalGroups.filter { $0.type == GroupType.custom }
    }
}
