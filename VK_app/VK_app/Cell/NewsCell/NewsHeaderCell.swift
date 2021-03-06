//
//  NewsHeaderCell.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 06/09/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class NewsHeaderCell: UITableViewCell {
    
    let groupAvatar = UIImageView()
    let groupLabel = UILabel()
    let timeLabel = UILabel()
    
    let indent: CGFloat = 10
    let iconWidth: CGFloat = 50
    
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
        let imageUrl = URL(string: group.groupAvatar)
        groupAvatar.kf.setImage(with: imageUrl)
        
        groupLabel.text = group.groupName
        groupLabel.backgroundColor = self.backgroundColor
           
        timeLabel.text = postDateFormatter.getcurrentDate(date: date)
        timeLabel.backgroundColor = self.backgroundColor
    }
    
    public func heightForCell() -> CGFloat {
        return iconWidth + indent
    }
    
    private func setIconFrame() {
        let size = CGSize(width: iconWidth, height: iconWidth)
        let origin = CGPoint(x: indent / 2, y: indent / 2)
        groupAvatar.frame = CGRect(origin: origin, size: size)
    }
    
    private func setGroupLabelFrame() {
        groupLabel.font = .boldSystemFont(ofSize: 16)
        let size = getLabelSize(text: groupLabel.text ?? "", font: groupLabel.font)
        let origin = CGPoint(x: indent * 2 + iconWidth, y: indent / 2 + iconWidth / 2 - size.height)
        groupLabel.frame = CGRect(origin: origin, size: size)
    }
    
    private func setTimeLabelFrame() {
        timeLabel.font = .systemFont(ofSize: 14)
        let size = getLabelSize(text: timeLabel.text ?? "", font: timeLabel.font)
        let origin = CGPoint(x: indent * 2 + iconWidth, y: indent + iconWidth / 2)
        timeLabel.frame = CGRect(origin: origin, size: size)
    }
    
    private func getLabelSize(text: String, font: UIFont) -> CGSize {
        let maxWidth = contentView.bounds.width - indent * 2 - iconWidth
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = text.boundingRect(with: textBlock, options: .truncatesLastVisibleLine, attributes: [NSAttributedString.Key.font: font], context: nil)
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
}
