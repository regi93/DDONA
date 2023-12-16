//
//  ChatTableViewCell.swift
//  ddona
//
//  Created by 유준용 on 2023/12/16.
//

import UIKit

class ChatBotTableViewCell: UITableViewCell {

    let textBox = UIView()
    let label = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(text: String){
        contentView.backgroundColor = UIColor(hexCode: "191919")
        self.selectionStyle = .none
        textBox.translatesAutoresizingMaskIntoConstraints = false
        textBox.backgroundColor = UIColor(hexCode: "6100FF")
        textBox.layer.cornerRadius = 12
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = text
        label.sizeToFit()
        self.contentView.addSubview(textBox)
        textBox.addSubview(label)
        
        for const in textBox.constraints {
            if const.firstAttribute == .width {
                const.isActive = false
            }
        }
        for const in label.constraints {
            if const.firstAttribute == .width {
                const.isActive = false
            }
        }
        
        NSLayoutConstraint.activate([
            textBox.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 61),
            textBox.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            label.leadingAnchor.constraint(equalTo: textBox.leadingAnchor, constant: 12),
            label.topAnchor.constraint(equalTo: textBox.topAnchor, constant: 6),
            label.bottomAnchor.constraint(equalTo: textBox.bottomAnchor, constant: -6),
            label.trailingAnchor.constraint(equalTo: textBox.trailingAnchor, constant: -12),
            textBox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        if text.count > 10 ,label.intrinsicContentSize.width >= 233 {
            NSLayoutConstraint.activate([
                label.widthAnchor.constraint(equalToConstant: 233),
            ])
        }else{
            NSLayoutConstraint.activate([
                label.widthAnchor.constraint(equalToConstant: label.sizeThatFits(CGSize(width: 233, height: 36)).width)
            ])
        }
    }

}

