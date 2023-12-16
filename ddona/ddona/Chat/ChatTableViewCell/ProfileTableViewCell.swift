//
//  ProfileTableViewCell.swift
//  ddona
//
//  Created by 유준용 on 2023/12/16.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    let profileImage = UIImageView()
    let nickNameLb = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(){
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor(hexCode: "191919")
        profileImage.image = UIImage(named: UserDefaults.standard.string(forKey: "MBTI") ?? "")
        profileImage.contentMode = .scaleAspectFit
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.cornerRadius = 16
        profileImage.layer.borderWidth = 0.5
        contentView.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalToConstant: 32),
            profileImage.heightAnchor.constraint(equalToConstant: 32),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        
        nickNameLb.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nickNameLb)
        nickNameLb.text = UserDefaults.standard.string(forKey: "nickName") ?? ""
        nickNameLb.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        nickNameLb.textColor = UIColor(hexCode: "C6C6C6")
        
        NSLayoutConstraint.activate([
            nickNameLb.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 8),
            nickNameLb.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor)
        ])
    }

}

