//
//  SegmentedControl.swift
//  SwiftHub
//
//  Created by Khoren Markosyan on 6/30/18.
//  Copyright © 2018 Khoren Markosyan. All rights reserved.
//

import UIKit

class SegmentedControl: UISegmentedControl {

    override init(items: [Any]?) {
        super.init(items: items)
        makeUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    func makeUI() {
        themeService.rx
            .bind({ $0.text }, to: rx.tintColor)
            .disposed(by: rx.disposeBag)

        layer.masksToBounds = true
        cornerRadius = 0
        snp.makeConstraints { (make) in
            make.height.equalTo(Configs.BaseDimensions.segmentedControlHeight)
        }
        updateUI()
    }

    func updateUI() {
        setNeedsDisplay()
    }
}
