//
//  MonthTitleCell.swift
//  Fridge Helper
//
//  Created by Penn on 11/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import IGListKit
import UIKit

final class MonthTitleCell: UICollectionViewCell {

    fileprivate lazy var label: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .center
        view.textColor = UIColor(white: 0.7, alpha: 1)
        view.font = .boldSystemFont(ofSize: 15)
        self.contentView.addSubview(view)
        return view
    }()

    var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }
}

extension MonthTitleCell: ListBindable {

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? MonthTitleViewModel else { return }
        label.text = viewModel.name.uppercased()
    }

}
