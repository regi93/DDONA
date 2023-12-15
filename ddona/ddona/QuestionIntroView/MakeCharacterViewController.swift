//
//  ViewController.swift
//  ddona
//
//  Created by 유준용 on 2023/12/13.
//

import UIKit

class MakeCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(hexCode: "#191919")
        configureNavBar()
        configureUI()
        configureLogo()
    }

    private func configureNavBar(){
        self.navigationController?.navigationBar.tintColor = .white
        let backButton = UIBarButtonItem()
        backButton.title = nil
        self.navigationItem.backBarButtonItem = backButton
    }
    
    private func configureUI(){
        let button = BottomButton()
        button.configureUI(title: "부캐 만들러 가기", radius: 26.5, type: .purple)
        button.addTarget(self, action: #selector(nextPage(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -27),
            button.heightAnchor.constraint(equalToConstant: 57)
        ])
    }
    

    private func configureLogo(){
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 25.5),
            logoImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 17),
            logoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
    }
    
    @objc func nextPage(_ btn: UIButton) {
        let vc = MakeCharacterDescViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

