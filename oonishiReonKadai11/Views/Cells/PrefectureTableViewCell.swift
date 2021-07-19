//
//  PrefectureTableViewCell.swift
//  oonishiReonKadai11
//
//  Created by 大西玲音 on 2021/07/19.
//

import UIKit

final class PrefectureTableViewCell: UITableViewCell {

    @IBOutlet private weak var prefectureNameLabel: UILabel!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
    func configure(prefectureName: String) {
        prefectureNameLabel.text = prefectureName
    }
    
}
