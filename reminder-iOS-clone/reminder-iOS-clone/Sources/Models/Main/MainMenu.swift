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
        totalGroups = [Group(type: GroupType.todo, title: GroupType.todo.rawValue, color: .red, todos: [], isSelect: true), Group(type: GroupType.today, title: GroupType.today.rawValue, color: .blue, todos: [], isSelect: true), Group(type: GroupType.flag, title: GroupType.flag.rawValue, color: .orange, todos: [], isSelect: true), Group(type: GroupType.forMe, title: GroupType.forMe.rawValue, color: .systemGreen, todos: [], isSelect: true), Group(type: GroupType.total, title: GroupType.total.rawValue, color: .darkGray, todos: [], isSelect: true), Group(type: GroupType.custom, title: "웅앵.", icon: "😁", color: .red, todos: [Todo(title: "애옹", memo: "누누", url: "url", flag: false)]), Group(type: GroupType.custom, title: "내일 할 일", icon: "✨", color: .blue, todos: [Todo(title: "우웅", memo: "낼 해야할", url: "url", flag: true)], isSelect: false)]
        totalTodos = []
        customGroups = totalGroups.filter { $0.type == GroupType.custom }
    }
}
