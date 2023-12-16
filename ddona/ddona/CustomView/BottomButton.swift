//
//  BottomButton.swift
//  ddona
//
//  Created by 유준용 on 2023/12/13.
//

import UIKit

class BottomButton: UIButton {
        
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureUI(title: String, radius: CGFloat, type: BtnType){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = radius
        self.setTitle(nil, for: .normal)
        configureTitleLabel(title: title)
        configureBtnType(type: type)
    }
    
    private func configureTitleLabel(title: String){
        titleLb.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLb.textColor = .white
        titleLb.text = title
        
        self.addSubview(titleLb)
        NSLayoutConstraint.activate([
            titleLb.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLb.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func configureBtnType(type: BtnType){
        switch type {
        case .purple:
            self.titleLb.textColor = .white
            self.backgroundColor = UIColor(hexCode: "6100FF")
        case .black:
            self.titleLb.textColor = .white
            self.backgroundColor = UIColor(hexCode: "2C2C2D")
        case .white:
            self.titleLb.textColor = UIColor(hexCode: "868686")
            self.backgroundColor = UIColor(hexCode: "DDDDDD")
        case .textField:
            self.titleLb.textColor = UIColor(hexCode: "868686")
            self.backgroundColor = .white
            self.layer.borderColor = UIColor(hexCode: "6100FF").cgColor
            self.layer.borderWidth = 3
            
        }
    }
    
    enum BtnType {
        case purple
        case white
        case textField
        case black
    }
}
