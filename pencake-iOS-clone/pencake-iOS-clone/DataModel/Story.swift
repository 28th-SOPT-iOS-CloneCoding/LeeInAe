//
//  Story.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/05/28.
//

import Foundation
import RealmSwift

class Story: Object {
    @objc dynamic var title: String
    @objc dynamic var subTitle: String
//    @objc dynamic var writings: [Writing]

    override init() {
        title = "이야기 1"
        subTitle = "여기를 눌러서 제목을 변경하세요"
//        writings = []
    }
}
