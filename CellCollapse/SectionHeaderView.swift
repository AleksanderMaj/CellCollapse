//
//  SectionHeaderView.swift
//  CellCollapse
//
//  Created by Aleksander Maj on 22/05/2018.
//  Copyright © 2018 HTD. All rights reserved.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {

    static let reuseId = "SectionHeaderView"
    static let nibName = "SectionHeaderView"

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .white
    }
}
