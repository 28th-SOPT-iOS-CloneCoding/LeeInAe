//
//  WritingViewModel.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/06/09.
//

import Foundation

protocol writingViewModelDelegate {
    func didChangedWriting(writing: Writing)
}

class WritingViewModel {
    // MARK: - property

    var writing: Writing? {
        willSet(newWriting) {
            guard let writing = newWriting else { return }

            writingDelegate?.didChangedWriting(writing: writing)
        }
    }

    // MARK: - delegate

    var writingDelegate: writingViewModelDelegate?
}
