//
//  QuestionViewController.swift
//  ddona
//
//  Created by 유준용 on 2023/12/13.
//

import UIKit

class QuestionViewController: UIViewController{

    
    let topView = BottomButton()
    var viewModel: QuestionViewModel?
    let questionLb = UILabel()
    var answerBtn = [BottomButton]()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    var process = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexCode: "#191919")
        collectionView.delegate = self
        collectionView.dataSource = self
        configureNavBar()
        configureTopView()
        configureCollectionView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel?.fetchQuestion(process: self.process) { [weak self] in
            self?.configureQuestionTitle(text: (self?.viewModel?.question)!)
            self?.configureAnswerView(number: 1, beforeYPosition: (self?.questionLb.bottomAnchor)!)
        }
    }
    
    func showNextQuestion(){
//        ///test
//        let vc = CreateNickNameViewController()
//        vc.process = self.process + 1
//        vc.viewModel = self.viewModel
//        self.navigationController?.pushViewController(vc, animated: true)
//        ///test
        
        if self.process < 18 {
            let vc = QuestionViewController()
            vc.viewModel = self.viewModel
            vc.process = self.process + 1
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = CreateNickNameViewController()
            vc.viewModel = self.viewModel
            vc.process = self.process + 1
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
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
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            collectionView.heightAnchor.constraint(equalToConstant: 32),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
        ])
    }
    
    private func configureQuestionTitle(text: String){
        questionLb.textColor = .white
        questionLb.numberOfLines = 0
        questionLb.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.42
        questionLb.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        questionLb.translatesAutoresizingMaskIntoConstraints = false
        questionLb.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        questionLb.textAlignment = .center
        self.view.addSubview(questionLb)
        NSLayoutConstraint.activate([
            questionLb.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 36),
            questionLb.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            questionLb.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
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
        answerView.tag = number
        answerView.configureUI(title: self.viewModel!.answer[number - 1], radius: 26.5, type: .white)
        self.view.addSubview(answerView)
        self.answerBtn.append(answerView)
        NSLayoutConstraint.activate([
            answerView.topAnchor.constraint(equalTo: numberView.bottomAnchor, constant: 10),
            answerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            answerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            answerView.heightAnchor.constraint(equalToConstant: 57)
        ])
        answerView.addTarget(self, action: #selector(answerTapped(_ :)), for: .touchUpInside)
        if number < 3 { configureAnswerView(number: number + 1, beforeYPosition: answerView.bottomAnchor)}
    }
    
    private func answerSelected(tag: Int){
        for btn in self.answerBtn {
            if btn.tag == tag{
                btn.configureBtnType(type: .purple)
            }
            else{
                btn.configureBtnType(type: .white)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            self.showNextQuestion()
        }
    }
    
    @objc func answerTapped(_ sender: UIButton){
        answerSelected(tag: sender.tag)
        self.viewModel?.selectedAnswer(idx: sender.tag - 1)
    }   
}


extension QuestionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.layer.cornerRadius = 4
        if indexPath.row < self.process {
            cell.contentView.backgroundColor = UIColor(hexCode: "6100FF")
            return cell
        }
        cell.contentView.backgroundColor = UIColor(hexCode: "2C2C2D")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 28, height: 12)
    }
}
