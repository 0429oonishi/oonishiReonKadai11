//
//  ViewModel.swift
//  oonishiReonKadai11
//
//  Created by 大西玲音 on 2021/07/19.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelInput {
    func prefectureInputButtonDidTapped()
}

protocol ViewModelOutput: AnyObject {
    var event: Driver<ViewModel.Event> { get }
}

protocol ViewModelType {
    var inputs: ViewModelInput { get }
    var outputs: ViewModelOutput { get }
}

final class ViewModel: ViewModelInput,
                       ViewModelOutput {
    enum Event {
        case screenTransition
    }
    var event: Driver<Event> {
        eventRelay.asDriver(onErrorDriveWith: .empty())
    }
    private let eventRelay = PublishRelay<Event>()
    
    func prefectureInputButtonDidTapped() {
        eventRelay.accept(.screenTransition)
    }
}

extension ViewModel: ViewModelType {
    
    var inputs: ViewModelInput {
        return self
    }
    
    var outputs: ViewModelOutput {
        return self
    }
    
}
