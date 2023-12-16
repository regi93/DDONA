//
//  ChatViewController.swift
//  ddona
//
//  Created by 유준용 on 2023/12/13.
//

import Foundation
import UIKit

class ChatViewController: UIViewController {
    let sendBtn = UIImageView()
    let plusContainerView = UIView()
    let tableView = UITableView()
    let chatTextField = UITextField()
    let viewModel = ChatViewModel()
    let chatFieldView = UIView()
    var keyboardStatus = Status.hide
    var plusButtonStatus = Status.hide
    var chatFieldViewConstarint: NSLayoutConstraint? = nil
    let plusIcon = UIImageView()
    var keyboardHeightConstant: CGFloat?
    let recommendLb1 = UILabel()
    let recommendLb2 = UILabel()
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plusContainerView.isHidden = true
        self.view.backgroundColor = UIColor(hexCode: "191919")
        let nickName = UserDefaults.standard.string(forKey: "nickName")
        self.title = nickName
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes?[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 18, weight: .bold)
        configureTableView()
        configureChatField()
        
        self.viewModel.fetchRecommend {
            self.configurePlusTab(reco1: self.viewModel.recommend1, reco2:self.viewModel.recommend2)
        }
        self.viewModel.load(completion: {
            self.tableView.reloadData()
        })
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if self.keyboardStatus == .show { return }
        if self.plusButtonStatus == .show { return }
        self.keyboardStatus = .show
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            self.keyboardHeightConstant = -(keyboardHeight - self.view.safeAreaInsets.bottom)
            if self.chatFieldViewConstarint?.constant == 0 {
                self.chatFieldViewConstarint?.constant = self.keyboardHeightConstant ?? 0.0
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if self.keyboardStatus == .hide { return }
        if self.plusButtonStatus == .show { return }
        self.keyboardStatus = .hide
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            if self.chatFieldViewConstarint?.constant == keyboardHeightConstant {
                self.chatFieldViewConstarint?.constant =  0.0
            }
        }
    }
    
    @objc func dismissKeyboard(){
        if self.plusButtonStatus == .show {
            return
        }

        self.view.endEditing(true)
        if self.chatFieldViewConstarint?.constant ?? 0 < -200 {
            chatFieldViewConstarint?.constant = 0
            switch self.plusButtonStatus {
            case .hide: // 지금 +
                self.plusButtonStatus = .show
                plusIcon.image = UIImage(named: "plushide")
                chatTextField.resignFirstResponder()
            case .show: // 지금 x
                self.plusButtonStatus = .hide
                plusIcon.image = UIImage(named: "plus")
                chatTextField.becomeFirstResponder()
            }
        }
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false  // Allow touches to be passed to the table view
        tableView.addGestureRecognizer(tapGesture)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(hexCode: "191919")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentMode = .scaleAspectFit
        tableView.estimatedRowHeight = 130
        tableView.separatorStyle = .none
        tableView.alwaysBounceHorizontal = false
        tableView.register(ChatBotTableViewCell.self, forCellReuseIdentifier: "chatBotCell")
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "profileCell")
        tableView.register(MyChatTableViewCell.self, forCellReuseIdentifier: "myChatCell")
        tableView.register(GuideTableViewCell.self, forCellReuseIdentifier: "guideCell")
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -44)
        ])
    }
    
    private func configureChatField(){
        chatFieldView.translatesAutoresizingMaskIntoConstraints = false
        chatFieldView.backgroundColor = UIColor(hexCode: "#1F1F1F")
        self.view.addSubview(chatFieldView)
        self.chatFieldViewConstarint = chatFieldView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        NSLayoutConstraint.activate([
            chatFieldView.heightAnchor.constraint(equalToConstant: 44),
            chatFieldView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            chatFieldView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            chatFieldViewConstarint!
        ])

        
        plusIcon.translatesAutoresizingMaskIntoConstraints = false
        plusIcon.image = UIImage(named: "plus")
        self.chatFieldView.addSubview(plusIcon)
        NSLayoutConstraint.activate([
            plusIcon.leadingAnchor.constraint(equalTo: chatFieldView.leadingAnchor, constant: 11),
            plusIcon.widthAnchor.constraint(equalToConstant: 24),
            plusIcon.topAnchor.constraint(equalTo: chatFieldView.topAnchor, constant: 10),
            plusIcon.bottomAnchor.constraint(equalTo: chatFieldView.bottomAnchor, constant: -10),
            plusIcon.heightAnchor.constraint(equalToConstant: 24)
        ])
        plusIcon.isUserInteractionEnabled = true
        plusIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(plus(_:))))
        
        let textFieldView = UIView()
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        textFieldView.backgroundColor = UIColor(hexCode: "404042")
        textFieldView.layer.cornerRadius = 15
        self.chatFieldView.addSubview(textFieldView)
        NSLayoutConstraint.activate([
            textFieldView.leadingAnchor.constraint(equalTo: plusIcon.trailingAnchor, constant: 7),
            textFieldView.topAnchor.constraint(equalTo: chatFieldView.topAnchor, constant: 4),
            textFieldView.bottomAnchor.constraint(equalTo: chatFieldView.bottomAnchor, constant: -4),
            textFieldView.trailingAnchor.constraint(equalTo: chatFieldView.trailingAnchor, constant: -16)
        ])

        sendBtn.translatesAutoresizingMaskIntoConstraints = false
        sendBtn.isUserInteractionEnabled = true
        sendBtn.image = UIImage(named: "send_disable")
        sendBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendMessage(_:))))
        textFieldView.addSubview(sendBtn)
        NSLayoutConstraint.activate([
            sendBtn.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -3),
            sendBtn.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 3),
            sendBtn.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -3),
            sendBtn.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        chatTextField.delegate = self
        chatTextField.translatesAutoresizingMaskIntoConstraints = false
        chatTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        chatTextField.textColor = UIColor(hexCode: "DDDDDD")
        textFieldView.addSubview(chatTextField)
        NSLayoutConstraint.activate([
            chatTextField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 18),
            chatTextField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -35),
            chatTextField.heightAnchor.constraint(equalToConstant: 20),
            chatTextField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 6),
            chatTextField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -6)
        ])
    }
    
    func configurePlusTab(reco1: String, reco2: String){
        
        plusContainerView.translatesAutoresizingMaskIntoConstraints = false
        plusContainerView.backgroundColor = UIColor(hexCode: "#1F1F1F")
        self.view.addSubview(plusContainerView)
        
        NSLayoutConstraint.activate([
            plusContainerView.topAnchor.constraint(equalTo: self.chatFieldView.bottomAnchor),
            plusContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            plusContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            plusContainerView.heightAnchor.constraint(equalToConstant: 282)
        ])
        
        
        let refreshImg = UIImageView()
        refreshImg.translatesAutoresizingMaskIntoConstraints = false
        refreshImg.isUserInteractionEnabled = true
        plusContainerView.addSubview(refreshImg)
        refreshImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(refreshRecomend(_:))))
        refreshImg.image = UIImage(named: "refresh")
        NSLayoutConstraint.activate([
            refreshImg.widthAnchor.constraint(equalToConstant: 24),
            refreshImg.heightAnchor.constraint(equalToConstant: 24),
            refreshImg.topAnchor.constraint(equalTo: plusContainerView.topAnchor, constant: 17),
            refreshImg.trailingAnchor.constraint(equalTo: plusContainerView.trailingAnchor, constant: -68)
        ])
        
        let refreshLb = UILabel()
        refreshLb.isUserInteractionEnabled = true
        refreshLb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(refreshRecomend(_:))))
        refreshLb.translatesAutoresizingMaskIntoConstraints = false
        plusContainerView.addSubview(refreshLb)
        refreshLb.text = "새로고침"
        refreshLb.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        refreshLb.textColor = UIColor(hexCode: "#B0B0B0")
        NSLayoutConstraint.activate([
            refreshLb.leadingAnchor.constraint(equalTo: refreshImg.trailingAnchor, constant: 3),
            refreshLb.bottomAnchor.constraint(equalTo: refreshImg.bottomAnchor, constant: -3)
        ])
        
        let titleView = UIView()
        plusContainerView.addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = UIColor(hexCode: "#420DA3")
        titleView.layer.cornerRadius = 20
        
        let titleLb = UILabel()
        titleLb.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        titleLb.textColor = .white
        titleLb.text = "오늘의 추천 제안 상황"
        titleLb.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(titleLb)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: plusContainerView.topAnchor, constant: 11),
            titleView.leadingAnchor.constraint(equalTo: plusContainerView.leadingAnchor, constant: 16),
            titleView.widthAnchor.constraint(equalToConstant: 181),
            titleView.heightAnchor.constraint(equalToConstant: 36),
            titleLb.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLb.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        ])
        
        let recommendView1 = UIView()
        recommendView1.translatesAutoresizingMaskIntoConstraints = false
        recommendView1.isUserInteractionEnabled = true
        recommendView1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendRecommend1Message(_:))))
        recommendView1.backgroundColor = UIColor(hexCode: "2C2C2D")
        recommendView1.layer.cornerRadius = 20
        plusContainerView.addSubview(recommendView1)
        
        
        recommendLb1.translatesAutoresizingMaskIntoConstraints = false
        recommendView1.addSubview(recommendLb1)
        recommendLb1.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        recommendLb1.numberOfLines = 0
        recommendLb1.textAlignment = .center
        recommendLb1.text = reco1
        NSLayoutConstraint.activate([
            recommendView1.heightAnchor.constraint(equalToConstant: 62),
            recommendView1.leadingAnchor.constraint(equalTo: plusContainerView.leadingAnchor, constant: 16),
            recommendView1.trailingAnchor.constraint(equalTo: plusContainerView.trailingAnchor, constant: -16),
            recommendView1.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10),
            
            recommendLb1.leadingAnchor.constraint(equalTo: recommendView1.leadingAnchor, constant: 20),
            recommendLb1.trailingAnchor.constraint(equalTo: recommendView1.trailingAnchor, constant: -20),
            recommendLb1.centerYAnchor.constraint(equalTo: recommendView1.centerYAnchor)
        ])
        
        let recommendView2 = UIView()
        recommendView2.isUserInteractionEnabled = true
        recommendView2.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(sendRecommend2Message(_:))))
        recommendView2.translatesAutoresizingMaskIntoConstraints = false
        recommendView2.backgroundColor = UIColor(hexCode: "2C2C2D")
        recommendView2.layer.cornerRadius = 20
        plusContainerView.addSubview(recommendView2)
        
        recommendLb2.translatesAutoresizingMaskIntoConstraints = false
        recommendView2.addSubview(recommendLb2)
        recommendLb2.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        recommendLb2.numberOfLines = 0
        recommendLb2.text = reco2
        recommendLb2.textAlignment = .center
        
        NSLayoutConstraint.activate([
            recommendView2.heightAnchor.constraint(equalToConstant: 62),
            recommendView2.leadingAnchor.constraint(equalTo: plusContainerView.leadingAnchor, constant: 16),
            recommendView2.trailingAnchor.constraint(equalTo: plusContainerView.trailingAnchor, constant: -16),
            recommendView2.topAnchor.constraint(equalTo: recommendView1.bottomAnchor, constant: 7),
            recommendLb2.leadingAnchor.constraint(equalTo: recommendView2.leadingAnchor, constant: 20),
            recommendLb2.trailingAnchor.constraint(equalTo: recommendView2.trailingAnchor, constant: -20),
            recommendLb2.centerYAnchor.constraint(equalTo: recommendView2.centerYAnchor)
        ])
        
        let descLb = UILabel()
        descLb.translatesAutoresizingMaskIntoConstraints = false
        plusContainerView.addSubview(descLb)
        descLb.text = "위 영역을 선택하면 부캐에게 상황이 제안됩니다!"
        descLb.textColor = UIColor(hexCode: "#9B9B9B")
        descLb.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descLb.textAlignment = .center
        NSLayoutConstraint.activate([
            descLb.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            descLb.topAnchor.constraint(equalTo: recommendView2.bottomAnchor, constant: 26)
        ])
    }
    
    @objc func sendRecommend2Message( _ : UITapGestureRecognizer){
        activityIndicator.startAnimating()
        self.plusButtonStatus = .hide
        plusIcon.image = UIImage(named: "plus")
        chatTextField.becomeFirstResponder()
        self.view.isUserInteractionEnabled = false
        self.viewModel.sendChat(message: recommendLb2.text ?? "") {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    @objc func sendRecommend1Message( _ : UITapGestureRecognizer){
        activityIndicator.startAnimating()
        self.plusButtonStatus = .hide
        plusIcon.image = UIImage(named: "plus")
        chatTextField.becomeFirstResponder()
        self.view.isUserInteractionEnabled = false
        self.viewModel.sendChat(message: recommendLb1.text ?? "") {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    @objc func refreshRecomend(_ : UITapGestureRecognizer){
        self.viewModel.fetchRecommend {
            self.recommendLb1.text = self.viewModel.recommend1
            self.recommendLb2.text = self.viewModel.recommend2
        }
    }
    
    @objc func plus(_: UITapGestureRecognizer){
        switch self.plusButtonStatus {
        case .hide: // 지금 +
            self.plusButtonStatus = .show
            plusIcon.image = UIImage(named: "plushide")
            plusContainerView.isHidden = false
            chatTextField.resignFirstResponder()
        case .show: // 지금 x
            self.plusButtonStatus = .hide
            plusIcon.image = UIImage(named: "plus")
            plusContainerView.isHidden = true
            chatTextField.becomeFirstResponder()
        }
    }

    @objc func sendMessage( _ :UITapGestureRecognizer){
        let text = self.chatTextField.text ?? ""
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        self.viewModel.sendChat(message: text) {
            print(self.viewModel.chatLog)
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
            self.chatTextField.text?.removeAll()
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chatLog.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.chatLog.count - 1 < indexPath.row {return UITableViewCell()}
        let data = viewModel.chatLog[indexPath.row]
        switch data.type {
        case .guide:
            let cell = tableView.dequeueReusableCell(withIdentifier: "guideCell") as! GuideTableViewCell
            cell.configureCell()
            return cell
        case .chatBot:
            let cell = tableView.dequeueReusableCell(withIdentifier: "chatBotCell", for: indexPath) as! ChatBotTableViewCell
            cell.configureCell(text: data.message)
            return cell
        case .myChat:
            let cell = tableView.dequeueReusableCell(withIdentifier: "myChatCell", for: indexPath) as! MyChatTableViewCell
            cell.configureCell(text: data.message)
            return cell
        case .chatBotProfile:
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileTableViewCell
            cell.configureCell()
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 { return 131 }
        return UITableView.automaticDimension
    }
}

extension ChatViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count ?? 0 > 0 {
            sendBtn.image = UIImage(named: "send_enable")
            sendBtn.isUserInteractionEnabled = true
        }else {
            sendBtn.image = UIImage(named: "send_disable")
            sendBtn.isUserInteractionEnabled = false
        }
        return true
    }
}

enum Status{
    case hide, show
}
