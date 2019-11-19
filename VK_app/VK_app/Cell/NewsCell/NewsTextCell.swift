//
//  NewsTextCell.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 06/09/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import SnapKit

class NewsTextCell: UITableViewCell {
    
    let newsTextView = UITextView()
   
    private let indent: CGFloat = 10
    let textFont = UIFont.systemFont(ofSize: 16)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "NewsTextCell")
        
        newsTextView.font = textFont
        //newsTextView.isScrollEnabled = false
        newsTextView.isEditable = false
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        newsTextView.font = textFont
        //newsTextView.isScrollEnabled = false
        newsTextView.isEditable = false
        
        setupSubviews()
    }
    
    private func setupSubviews() {
        contentView.addSubview(newsTextView)
        
        newsTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        setNeedsLayout()
    }
    
    func setTextViewFrame() {
        newsTextView.font = textFont
        let size = getTextViewSize(text: newsTextView.text ?? "", font: textFont)
        let origin = CGPoint(x: indent, y: indent)
        newsTextView.frame = CGRect(origin: origin, size: size)
    }
    
     func getTextViewSize(text: String, font: UIFont) -> CGSize {
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
    
    public func heightForCell(with data: News) -> CGFloat {
        let text = data.text
        let maxWidth = contentView.bounds.width
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let textHeight = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textFont], context: nil).height
        let oneLineHeight = text.boundingRect(with: textBlock, options: .usesFontLeading, attributes: [NSAttributedString.Key.font: textFont], context: nil).height
        let maxHeight = oneLineHeight * 7
        if textHeight > maxHeight {
            return maxHeight + oneLineHeight
        } else {
            return textHeight + oneLineHeight
        }
    }
    
    public func heightForScroll(with data: News) -> Bool {
        let text = data.text
        let maxWidth = contentView.bounds.width
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let textHeight = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textFont], context: nil).height
        let oneLineHeight = text.boundingRect(with: textBlock, options: .usesFontLeading, attributes: [NSAttributedString.Key.font: textFont], context: nil).height
        let maxHeight = oneLineHeight * 7
        if textHeight > maxHeight {
            return true
        } else {
            return false
        }
    }
}
