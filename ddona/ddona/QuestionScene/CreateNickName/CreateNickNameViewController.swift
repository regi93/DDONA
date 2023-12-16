//
//  CreateNickNameViewController.swift
//  ddona
//
//  Created by 유준용 on 2023/12/16.
//

import UIKit

class CreateNickNameViewController: UIViewController {
    
    let topView = BottomButton()
    let completeBtn = BottomButton()
    var viewModel: QuestionViewModel?
    let questionLb = UILabel()
    let tf = UITextField()
    let textFieldView = BottomButton()
    
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
        self.configureQuestionTitle(text: "자신의 부캐에게\n지어주고 싶은 이름은?")
        self.configureTextField()
        self.configureCompleteBtn()
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
        var paragraphStyle = NSMutableParagraphStyle()
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
    
    private func configureTextField(){
        textFieldView.configureUI(title: "이름을 적어주세요.", radius: 26.5, type: .textField)

        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self
        tf.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        tf.textColor = .black
        textFieldView.addSubview(tf)
        
        self.view.addSubview(textFieldView)
        NSLayoutConstraint.activate([
            textFieldView.bottomAnchor.constraint(equalTo: self.questionLb.bottomAnchor, constant: 130),
            textFieldView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            textFieldView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            textFieldView.heightAnchor.constraint(equalToConstant: 57),
            tf.centerYAnchor.constraint(equalTo: textFieldView.centerYAnchor),
            tf.heightAnchor.constraint(equalToConstant: 25),
            tf.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 20),
            tf.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureCompleteBtn(){
        completeBtn.isUserInteractionEnabled = false
        completeBtn.configureUI(title: "완료하기", radius: 26.5, type: .white)
        self.view.addSubview(completeBtn)
        NSLayoutConstraint.activate([
            completeBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -17),
            completeBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            completeBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            completeBtn.heightAnchor.constraint(equalToConstant: 57)
        ])
        completeBtn.addTarget(self, action: #selector(complete(_:)), for: .touchUpInside)
    }
    
    @objc func complete(_ sender : UIButton){
        UserDefaults.standard.set(tf.text ?? "AI봇", forKey: "nickName")
        UserDefaults.standard.synchronize()
        let vc = CompleteViewController()
        vc.viewModel = viewModel
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


extension CreateNickNameViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource {
    
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


extension CreateNickNameViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldView.configureUI(title: "", radius: 26.5, type: .textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 0 {
            completeBtn.configureBtnType(type: .purple)
            completeBtn.isUserInteractionEnabled = true
        }else{
            completeBtn.configureBtnType(type: .white)
            textFieldView.configureUI(title: "이름을 적어주세요.", radius: 26.5, type: .textField)
            completeBtn.isUserInteractionEnabled = false
        }
    }
    
}
