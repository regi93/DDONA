//
//  BottomButton.swift
//  ddona
//
//  Created by 유준용 on 2023/12/13.
//

import UIKit

class BottomButton: UIButton {
    
    var type: BtnType!
    
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
    
    func configureUI(title: String, type: BtnType){
        self.type = type
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 27.5
        self.setTitle(nil, for: .normal)
        configureTitleLabel(title: title)
        configureBtnType()
    }
    
    func configureTitleLabel(title: String){
        titleLb.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLb.textColor = .white
        titleLb.text = title
        
        self.addSubview(titleLb)
        NSLayoutConstraint.activate([
            titleLb.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLb.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func configureBtnType(){
        switch self.type {
        case .purple:
            self.titleLb.textColor = .white
            self.backgroundColor = UIColor(hexCode: "6100FF")
        case .grey:
            self.titleLb.textColor = UIColor(hexCode: "868686")
            self.backgroundColor = UIColor(hexCode: "DDDDDD")
        case .none:
            break
        }
    }
    
    enum BtnType {
        case purple
        case grey
    }
}
