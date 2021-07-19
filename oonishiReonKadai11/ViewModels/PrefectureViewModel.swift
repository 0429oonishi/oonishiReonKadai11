//
//  PrefectureViewModel.swift
//  oonishiReonKadai11
//
//  Created by 大西玲音 on 2021/07/19.
//

import Foundation
import RxSwift
import RxCocoa

protocol PrefectureViewModelInput {
    func cellDidTapppd(name: String)
    func cancelButtonDidTapped()
}

protocol PrefectureViewModelOutput: AnyObject {
    var prefectureNames: [String] { get }
    var event: Driver<PrefectureViewModel.Event> { get }
}

protocol PrefectureViewModelType {
    var inputs: PrefectureViewModelInput { get }
    var outputs: PrefectureViewModelOutput { get }
}

final class PrefectureViewModel: PrefectureViewModelInput,
                                 PrefectureViewModelOutput {
    
    enum Event {
        case cellDidTapped(name: String)
        case cancelButtonDidTapped
    }
    var event: Driver<Event> {
        eventRelay.asDriver(onErrorDriveWith: .empty())
    }
    private let eventRelay = PublishRelay<Event>()
    
    let prefectureNames = Prefecture.name
    
    func cellDidTapppd(name: String) {
        eventRelay.accept(.cellDidTapped(name: name))
    }
    
    func cancelButtonDidTapped() {
        eventRelay.accept(.cancelButtonDidTapped)
    }
    
}

extension PrefectureViewModel: PrefectureViewModelType {
    
    var inputs: PrefectureViewModelInput {
        return self
    }
    
    var outputs: PrefectureViewModelOutput {
        return self
    }
    
}
