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
        totalGroups = [Group(type: GroupType.todo, todos: [], isSelect: true), Group(type: GroupType.today, todos: [], isSelect: true), Group(type: GroupType.flag, todos: [], isSelect: true), Group(type: GroupType.forMe, todos: [], isSelect: true), Group(type: GroupType.total, todos: [], isSelect: true), Group(type: GroupType.custom, title: "웅앵.", icon: "😁", color: .red, todos: []), Group(type: GroupType.custom, title: "내일 할 일", icon: "✨", color: .blue, todos: [], isSelect: false)]
        totalTodos = []
        customGroups = totalGroups.filter { $0.type == GroupType.custom }
    }
}
