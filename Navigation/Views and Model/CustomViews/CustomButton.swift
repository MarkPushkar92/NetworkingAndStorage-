//
//  CustomButton.swift
//  Navigation
//
//  Created by Марк Пушкарь on 04.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    var onTap: (() -> Void)?
    var title: String
    var titleColor: UIColor
    
    init(title: String, titleColor: UIColor, onTap: (() -> Void)?) {
        self.title = title
        self.onTap = onTap
        self.titleColor = titleColor
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        onTap?()
    }
    
}

