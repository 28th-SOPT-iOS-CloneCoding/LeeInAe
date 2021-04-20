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
    var isSelect: Bool = false
}

enum GroupType: String {
    case today = "오늘"
    case todo = "예정"
    case forMe = "나에게 할당"
    case total = "전체"
    case flag = "깃발 표시"
}
