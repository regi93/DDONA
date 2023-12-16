//
//  ChatTableViewCell.swift
//  ddona
//
//  Created by 유준용 on 2023/12/16.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

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
        self.selectionStyle = .none
        textBox.translatesAutoresizingMaskIntoConstraints = false
        textBox.backgroundColor = UIColor(hexCode: "6100FF")
        textBox.layer.cornerRadius = 12
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.text = text
        self.contentView.addSubview(textBox)
        textBox.addSubview(label)
        
        NSLayoutConstraint.activate([
            textBox.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 61),
            textBox.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            label.leadingAnchor.constraint(equalTo: textBox.leadingAnchor, constant: 12),
            label.topAnchor.constraint(equalTo: textBox.topAnchor, constant: 6),
            label.bottomAnchor.constraint(equalTo: textBox.bottomAnchor, constant: -6),
            label.trailingAnchor.constraint(equalTo: textBox.trailingAnchor, constant: -12),
            textBox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        if label.intrinsicContentSize.width >= 245{
            NSLayoutConstraint.activate([
                label.widthAnchor.constraint(equalToConstant: 245),
            ])
        }
    }

}

