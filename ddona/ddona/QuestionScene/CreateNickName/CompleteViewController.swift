//
//  CompleteViewController.swift
//  ddona
//
//  Created by 유준용 on 2023/12/16.
//

import Foundation
import UIKit

class CompleteViewController: UIViewController {
    
    let completeBtn = BottomButton()
    let topView = BottomButton()
    var viewModel: QuestionViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexCode: "#191919")
        configureTopView()
        configureCompleteBtn()
        viewModel?.calculateScore { [weak self] in
            self?.configureTextBox(mbti: self?.viewModel?.calculateResult?.type ?? "")
        }
    }
    
    private func configureTextBox(mbti: String) {
        
        let containerView = UIView()
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(hexCode: "6100FF", alpha: 0.2)
        containerView.layer.cornerRadius = 28
        containerView.layer.borderColor = UIColor(hexCode: "6100FF").cgColor
        containerView.layer.borderWidth = 1
        self.view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 58),
        ])
        
        
        let nickName = UserDefaults.standard.string(forKey: "nickName")
        topView.configureUI(title: nickName ?? "나의 부캐" , radius: 19.5, type: .purple)
        self.view.addSubview(topView)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 17),
            topView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            topView.heightAnchor.constraint(equalToConstant: 39),
            topView.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        
        let upperView = UIView()
        containerView.addSubview(upperView)
        upperView.backgroundColor = UIColor(hexCode: "32374b")
        upperView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upperView.topAnchor.constraint(equalTo: containerView.topAnchor),
            upperView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: -1),
            upperView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 1),
            upperView.heightAnchor.constraint(equalToConstant: 318)
        ])
        
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = UIColor(hexCode: "32374b")
        imgView.image = UIImage(named: mbti)
        upperView.addSubview(imgView)
        
        NSLayoutConstraint.activate([
            imgView.widthAnchor.constraint(equalToConstant: 288),
            imgView.heightAnchor.constraint(equalToConstant: 228),
            imgView.centerXAnchor.constraint(equalTo: upperView.centerXAnchor),
            imgView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10)
        ])
        
        
        let titleLb = UILabel()
        titleLb.translatesAutoresizingMaskIntoConstraints = false
        titleLb.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleLb.textColor = .white
        titleLb.text = viewModel?.calculateResult?.name
        containerView.addSubview(titleLb)
        NSLayoutConstraint.activate([
            titleLb.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLb.topAnchor.constraint(equalTo: upperView.bottomAnchor, constant: 17)
        ])
        
        let descLb = UILabel()
        descLb.translatesAutoresizingMaskIntoConstraints = false
        descLb.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        descLb.numberOfLines = 0
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.42
        descLb.attributedText = NSMutableAttributedString(string: viewModel?.calculateResult?.description ?? "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        descLb.textAlignment = .center
        containerView.addSubview(descLb)
        NSLayoutConstraint.activate([
            descLb.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            descLb.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            descLb.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 7),
            containerView.bottomAnchor.constraint(equalTo: descLb.bottomAnchor, constant: 24)
        ])
        
        
        
    }
    
    private func configureTopView(){

    }
    
    private func configureCompleteBtn(){
        completeBtn.isUserInteractionEnabled = false
        completeBtn.configureUI(title: "나의 부캐와 대화하러 가기", radius: 26.5, type: .purple)
        self.view.addSubview(completeBtn)
        NSLayoutConstraint.activate([
            completeBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -17),
            completeBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            completeBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            completeBtn.heightAnchor.constraint(equalToConstant: 57)
        ])
        completeBtn.addTarget(self, action: #selector(goChat(_:)), for: .touchUpInside)
    }
    
    @objc func goChat(_ sender: UIButton){
        print(#function)
    }
}
