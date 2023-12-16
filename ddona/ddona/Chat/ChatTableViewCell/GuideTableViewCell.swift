//
//  GuideTableViewCell.swift
//  ddona
//
//  Created by 유준용 on 2023/12/16.
//

import Foundation
import UIKit

class GuideTableViewCell: UITableViewCell{
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(){
        contentView.backgroundColor = UIColor(hexCode: "191919")
        
        let box = UIView()
        box.backgroundColor = UIColor(hexCode: "383839")
        box.translatesAutoresizingMaskIntoConstraints = false
        box.layer.cornerRadius = 28
        contentView.addSubview(box)
        
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.26
        lb.attributedText = NSMutableAttributedString(string: "부캐에게 여러 가지를 질문을 던져보세요! \n혹시 특정 상황을 떠올리는 게 어렵게 느껴진다면\n채팅바 왼쪽에 있는 플러스 버튼을 눌러 \n오늘의 추천 상황 제안을 이용할 수도 있습니다!", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        lb.textAlignment = .center

        box.addSubview(lb)
        NSLayoutConstraint.activate([
            box.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            box.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            box.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            box.heightAnchor.constraint(equalToConstant: 115),
            lb.topAnchor.constraint(equalTo: box.topAnchor, constant: 15),
            lb.bottomAnchor.constraint(equalTo: box.bottomAnchor, constant: -15),
            lb.trailingAnchor.constraint(equalTo: box.trailingAnchor, constant: -40),
            lb.leadingAnchor.constraint(equalTo: box.leadingAnchor, constant: 40),
            
        ])
    }
}
