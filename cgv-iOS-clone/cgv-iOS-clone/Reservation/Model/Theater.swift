//
//  Theater.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/21.
//

import Foundation

class Theater {
    static let theater = Theater()

    var selectedIdx: Int = 0 {
        willSet(newValue) {
            subRegionArr.removeAll()
            subRegionArr.append(contentsOf: getSubRegionData(idx: newValue))
        }
    }

    let regionArr: [String] = ["추천 CGV", "서울", "경기", "인천", "강원", "대전/충청", "대구", "부산/울산", "경상", "광주/전라/제주"]
    var subRegionArr: [String] = []

    private func getSubRegionData(idx: Int) -> [String] {
        switch idx {
        case 0:
            return ["불광", "명동역 씨네라이브러리"]
        case 1:
            return ["강남", "강변", "건대입구", "구로", "대학로", "동대문", "등촌", "명동", "명동역 씨네라이브러리", "목동", "미아", "불광", "상봉", "성신여대입구", "송파"]
        case 2:
            return ["경기광주", "고양행신", "광교", "광교상현", "구리", "김포", "김포운양", "김포풍무", "김포한강", "동백", "동수원", "동탄", "동탄역"]
        case 3:
            return ["계양", "남주안", "부평", "송도타임스체이스"]
        default:
            return ["무"]
        }
    }
}
