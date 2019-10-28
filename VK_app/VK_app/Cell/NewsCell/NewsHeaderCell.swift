//
//  NewsHeaderCell.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 06/09/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class NewsHeaderCell: UITableViewCell {

    private let groupAvatar = UIImageView()
    private let groupLabel = UILabel()
    private let timeLabel = UILabel()
    
    private let indent: CGFloat = 10
    private let iconWidth: CGFloat = 50
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "NewsHeaderCell")
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupSubviews()
    }
    
    private func setupSubviews() {
        addSubview(groupAvatar)
        addSubview(groupLabel)
        addSubview(timeLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setIconFrame()
        setGroupLabelFrame()
        setTimeLabelFrame()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        setNeedsLayout()
    }
    
    public func configure(with group: NewsGroup, date: Int, postDateFormatter: NewsfeedDateFormatter) {
        groupLabel.text = group.groupName
        
        let imageUrl = URL(string: group.groupAvatar)
        groupAvatar.kf.setImage(with: imageUrl)
        
        timeLabel.text = postDateFormatter.getcurrentDate(date: date)
    }
    
    private func setIconFrame() {
        let size = CGSize(width: iconWidth, height: iconWidth)
        let origin = CGPoint(x: indent, y: indent)
        groupAvatar.frame = CGRect(origin: origin, size: size)
    }
    
    private func setGroupLabelFrame() {
        let size = getLabelSize(text: groupLabel.text ?? "", font: groupLabel.font)
        let origin = CGPoint(x: indent * 2 + iconWidth, y: indent)
        groupLabel.frame = CGRect(origin: origin, size: size)
    }
    
    private func setTimeLabelFrame() {
        let size = timeLabel.intrinsicContentSize
        let origin = CGPoint(x: indent * 2 + iconWidth, y: indent + iconWidth / 2)
        timeLabel.frame = CGRect(origin: origin, size: size)
    }
    
    private func getLabelSize(text: String, font: UIFont) -> CGSize {
        let maxWidth = contentView.bounds.width - indent * 2 - iconWidth
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
}
