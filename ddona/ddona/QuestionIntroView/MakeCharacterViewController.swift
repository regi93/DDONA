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
        self.view.backgroundColor = UIColor(hexCode: "191919")
        configureNavBar()
        configureUI()
        
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
        let imgView = UIImageView()
        self.view.addSubview(imgView)
        imgView.image = UIImage(named: "intro")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleToFill
        NSLayoutConstraint.activate([
            imgView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imgView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            imgView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imgView.bottomAnchor.constraint(equalTo: button.topAnchor)
        ])
    }
    
    
    @objc func nextPage(_ btn: UIButton) {
        let vc = MakeCharacterDescViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

