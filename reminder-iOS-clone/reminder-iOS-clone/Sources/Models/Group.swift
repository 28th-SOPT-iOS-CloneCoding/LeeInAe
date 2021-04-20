//
//  Group.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/20.
//

import Foundation

struct Group {
    var title: String
    var todos: [Todo]
}

struct Todo {
    var title: String
    var memo: String
    var URL: String
    var date: Date?
    var time: String?
    var flag: Bool
}
