//
//  Database.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/06/07.
//

import Foundation
import RealmSwift

class Database {
    static let shared = Database()

    let realm = try! Realm()
    var notificationToken: NotificationToken?

    init() {
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }

    func fetchStoryData() {
        let stories = realm.objects(Story.self)

        if stories.isEmpty {
            /// 초기값 세팅
            let mainStory = Story()
            mainStory.index = 1
            mainStory.title = "이야기1"
            mainStory.subTitle = "여기를 눌러서 제목을 변경하세요"

            mainStory.writings.append(Writing())
            mainStory.writings.append(Writing())
            mainStory.writings.append(Writing())

            let storyVC = StoryVC(viewModel: StoryViewModel())
            storyVC.viewModel.storyDelegate = storyVC
            storyVC.viewModel.story = mainStory

            ContainerVC.pages.append(storyVC)

            try! realm.write {
                realm.add(mainStory)
            }
        } else {
            for idx in 1 ... stories.count {
                guard let story = stories.filter("index == \(idx)").first else { return }

                let storyVC = StoryVC(viewModel: StoryViewModel())
                storyVC.viewModel.storyDelegate = storyVC
                storyVC.viewModel.story = story

                ContainerVC.pages.append(storyVC)
            }
        }
    }

    func updateStory() {
        let stories = realm.objects(Story.self)

        for idx in 1 ... stories.count {
            guard let story = stories.filter("index == \(idx)").first else { return }

            if let storyVC = ContainerVC.pages[idx] as? StoryVC {
                storyVC.viewModel.storyDelegate = storyVC
                storyVC.viewModel.story = story

                ContainerVC.pages[idx] = storyVC
            }
        }
    }

    func saveModelData(model: Object) -> Bool {
        do {
            try realm.write {
                realm.add(model)
            }

            return true
        } catch {
            return false
        }
    }

    func getTotalCount<T: Object>(model: T.Type) -> Int {
        realm.objects(model).count
    }
}