//
//  CharacterPickerView.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 22/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

enum Characters: Int {
    case a
    case b
    case c
    
    static let firstCharacter: [Characters] = [a, b, c]
    
    var title: String {
        switch self {
        case .a: return "Aa"
        case .b: return "Bb"
        case .c: return "Cc"
        
        }
    }
}

class CharacterPickerView: UIControl {

    var selectedChar: Characters? = nil {
        didSet {
            self.updateSelectedChar()
            self.sendActions(for: .valueChanged)
        }
    }
    
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    
    private func setupView() {
        for character in Characters.firstCharacter {
            let button = UIButton(type: .system)
            button.setTitle(character.title, for: .normal)
            button.addTarget(self, action: #selector(selectChar(_:)), for: .touchUpInside)
            self.buttons.append(button)
            
        }
        
        stackView = UIStackView(arrangedSubviews: self.buttons)
        self.addSubview(stackView)
        
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    
    }
    
    private func updateSelectedChar() {
        for (index, button) in self.buttons.enumerated()  {
            guard let character = Characters(rawValue: index) else { continue }
            button.isSelected = character == self.selectedChar
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    @objc private func selectChar(_ sender: UIButton) {
        guard let index = self.buttons.firstIndex(of: sender) else { return }
        guard let character = Characters(rawValue: index) else { return }
        self.selectedChar = character
    }

}
