//
//  StoryViewModel.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/06/03.
//

import Foundation

protocol StoryViewModelDelegate {
    func didChangedStory(story: Story)
}

class StoryViewModel {
    // MARK: - property

    var story: Story? {
        willSet(newStory) {
            print("new story! 🤖")
            guard let story = newStory else { return }

            storyDelegate?.didChangedStory(story: story)
        }
    }

    // MARK: - delegate

    var storyDelegate: StoryViewModelDelegate?
}
