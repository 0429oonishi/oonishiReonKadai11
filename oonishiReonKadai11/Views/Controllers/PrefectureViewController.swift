//
//  PrefectureViewController.swift
//  oonishiReonKadai11
//
//  Created by 大西玲音 on 2021/07/19.
//

import UIKit
import RxSwift
import RxCocoa

final class PrefectureViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var cancelButton: UIBarButtonItem!
    
    private let viewModel: PrefectureViewModelType = PrefectureViewModel()
    private let disposeBag = DisposeBag()
    var didSelect: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupBindings()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(PrefectureTableViewCell.nib,
                           forCellReuseIdentifier: PrefectureTableViewCell.identifier)
    }
    
    private func setupBindings() {
        cancelButton.rx.tap
            .subscribe(onNext: viewModel.inputs.cancelButtonDidTapped)
            .disposed(by: disposeBag)
        
        viewModel.outputs.event
            .drive(onNext: { [weak self] event in
                switch event {
                    case .dismiss(name: let name):
                        if let name = name {
                            self?.didSelect?(name)
                        }
                }
            })
            .disposed(by: disposeBag)
    }
    
    static func instantiate() -> PrefectureViewController {
        let storyboard = UIStoryboard(name: "Prefecture", bundle: nil)
        let prefectureVC = storyboard.instantiateViewController(
            identifier: "PrefectureViewController"
        ) as! PrefectureViewController
        prefectureVC.modalPresentationStyle = .fullScreen
        return prefectureVC
    }
    
}

extension PrefectureViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let prefectureName = viewModel.outputs.prefectureNames[indexPath.row]
        viewModel.inputs.cellDidTapppd(name: prefectureName)
    }
    
}

extension PrefectureViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputs.prefectureNames.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PrefectureTableViewCell.identifier
        ) as! PrefectureTableViewCell
        let prefectureName = viewModel.outputs.prefectureNames[indexPath.row]
        cell.configure(prefectureName: prefectureName)
        return cell
    }
    
    
}
