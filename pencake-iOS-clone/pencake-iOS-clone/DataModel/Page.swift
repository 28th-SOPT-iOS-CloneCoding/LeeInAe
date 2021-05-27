//
//  Page.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/05/27.
//

import Foundation
import RealmSwift
import UIKit

class Page: Object {
    @objc dynamic var pages: [UIViewController]

    override init() {
        pages = [StoryVC(), AddStoryVC()]
    }
}
