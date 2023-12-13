//
//  MakeCharacterDescViewController.swift
//  ddona
//
//  Created by 유준용 on 2023/12/13.
//

import UIKit

class MakeCharacterDescViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexCode: "#191919")
        configureNavBar()
        configureDescImageView()
        configureBtn()
    }
    
    private func configureNavBar(){
        self.navigationController?.navigationBar.tintColor = .white
        let backButton = UIBarButtonItem()
        backButton.title = nil
        self.navigationItem.backBarButtonItem = backButton
    }
    
    private func configureDescImageView(){
        let imgView = UIImageView()
        imgView.image = UIImage(named: "description")
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(imgView)
        NSLayoutConstraint.activate([
            imgView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            imgView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            imgView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            imgView.heightAnchor.constraint(equalToConstant: (self.view.frame.width - 32) * 0.9883)
        ])
    }
    
    private func configureBtn(){
        let btn = BottomButton()
        btn.configureUI(title: "다음으로 이동", type: .purple)
        btn.addTarget(self, action: #selector(nextPage(_ :)), for: .touchUpInside)
        self.view.addSubview(btn)
        NSLayoutConstraint.activate([
            btn.heightAnchor.constraint(equalToConstant: 57),
            btn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            btn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -27)
        ])
    }
    
    @objc func nextPage(_ : UIButton){
        let vc = QuestionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
