//
//  ViewController.swift
//  oonishiReonKadai11
//
//  Created by 大西玲音 on 2021/07/19.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
    
    @IBOutlet private weak var prefectureNameLabel: UILabel!
    @IBOutlet private weak var prefectureInputButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private let viewModel: ViewModelType = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        
    }
    
    private func setupBindings() {
        prefectureInputButton.rx.tap
            .subscribe(onNext: viewModel.inputs.prefectureInputButtonDidTapped)
            .disposed(by: disposeBag)
        
        viewModel.outputs.event
            .drive(onNext: { [weak self] event in
                switch event {
                    case .screenTransition:
                        let prefectureVC = PrefectureViewController.instantiate()
                        prefectureVC.didSelect = { [weak self] name in
                            self?.prefectureNameLabel.text = name
                        }
                        self?.present(prefectureVC, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }
    
}

