//
//  QuestionViewController.swift
//  ddona
//
//  Created by 유준용 on 2023/12/13.
//

import UIKit

class QuestionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    let topView = BottomButton()
    let viewModel = QuestionViewModel()
    let questionLb = UILabel()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    let process = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexCode: "#191919")
        collectionView.delegate = self
        collectionView.dataSource = self
        configureNavBar()
        configureTopView()
        configureCollectionView()
        configureQuestionTitle()
        configureAnswerView(number: 1, beforeYPosition: questionLb.bottomAnchor)
    }
    
    
    private func configureNavBar(){
        self.navigationController?.navigationBar.tintColor = .white
        let backButton = UIBarButtonItem()
        backButton.title = nil
        self.navigationItem.backBarButtonItem = backButton
    }
    
    private func configureTopView(){
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.configureUI(title: "Q\(process)", radius: 19.5, type: .purple)
        self.view.addSubview(topView)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 4),
            topView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            topView.heightAnchor.constraint(equalToConstant: 39),
            topView.widthAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    private func configureCollectionView(){
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.collectionView)
        collectionView.backgroundColor = .red
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 32),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    private func configureQuestionTitle(){
        
        questionLb.text = "중요한 일을 맡게된 당신, \n 이 때 가장 먼저 할 당신의 반응은?"
        
        questionLb.textColor = .white
        questionLb.numberOfLines = 0
        questionLb.textAlignment = .center
        questionLb.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        questionLb.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(questionLb)
        NSLayoutConstraint.activate([
            questionLb.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 36),
            questionLb.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            questionLb.heightAnchor.constraint(equalToConstant: 62)
        ])
    }
    
    private func configureAnswerView(number: Int, beforeYPosition: NSLayoutYAxisAnchor){
        
        let numberView = BottomButton()
        numberView.configureUI(title: "\(number)", radius: 17, type: .black)
        
        self.view.addSubview(numberView)
        NSLayoutConstraint.activate([
            numberView.widthAnchor.constraint(equalToConstant: 34),
            numberView.heightAnchor.constraint(equalToConstant: 34),
            numberView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            numberView.topAnchor.constraint(equalTo: beforeYPosition, constant: 39)
        ])
        
        let answerView = BottomButton()
        answerView.configureUI(title: "무슨일이 있는지 물어볼래", radius: 26.5, type: .white)
        self.view.addSubview(answerView)
        NSLayoutConstraint.activate([
            answerView.topAnchor.constraint(equalTo: numberView.bottomAnchor, constant: 10),
            answerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            answerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            answerView.heightAnchor.constraint(equalToConstant: 57)
        ])
        
        if number < 3 { configureAnswerView(number: number + 1, beforeYPosition: answerView.bottomAnchor)}
    }
    
}
