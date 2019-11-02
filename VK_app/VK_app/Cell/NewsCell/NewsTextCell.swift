//
//  NewsTextCell.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 06/09/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class NewsTextCell: UITableViewCell {
    
    private let newsTextView = UITextView()
    
    private let indent: CGFloat = 10

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "NewsTextCell")
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupSubviews()
    }
    
    private func setupSubviews() {
        addSubview(newsTextView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setTextViewFrame()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        setNeedsLayout()
    }
    
    private func setTextViewFrame() {
        newsTextView.font = .systemFont(ofSize: 14)
        let size = getTextViewSize(text: newsTextView.text ?? "", font: newsTextView.font!)
        let origin = CGPoint(x: indent, y: indent)
        newsTextView.frame = CGRect(origin: origin, size: size)
    }
    
    private func getTextViewSize(text: String, font: UIFont) -> CGSize {
        let maxWidth = contentView.bounds.width
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
    
    public func configure(with data: News) {
        newsTextView.text = data.text
    }
}
