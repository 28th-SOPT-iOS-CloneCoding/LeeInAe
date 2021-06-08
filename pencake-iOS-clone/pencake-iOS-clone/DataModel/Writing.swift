//
//  Writing.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/05/28.
//

import Foundation
import RealmSwift

class Writing: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title: String
    @objc dynamic var date: Date
    @objc dynamic var content: String

    override init() {
        title = "글 1"
        date = Date()
        content = "세상에는 수많은 이야기로 넘쳐납니다."
    }

    override static func primaryKey() -> String? {
        "id"
    }
}
