//
//  ViewController.swift
//  LoginUI
//
//  Created by 유준용 on 2021/05/25.
//

import UIKit

class ViewController: UIViewController {

    let charSet : CharacterSet = {
        var cs = CharacterSet.lowercaseLetters
        cs.insert(charactersIn : "0123456789")
        cs.insert(charactersIn: "-")
        return cs.inverted
    }()
    

    
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var placeHolderLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var placeHolder: UILabel!
    
    
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    var tokens = [NSObjectProtocol]() // 옵저버 등록을 위한 토큰
    deinit { // 옵저버 제거
        tokens.forEach { NotificationCenter.default.removeObserver($0)}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textField.becomeFirstResponder() // 바로 키보드를 뜨게만듬
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nextButton.isEnabled = false // 양식 입력 전 버튼 비활성화

        self.textField.delegate = self
        var token = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
            if let frameValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardFrame = frameValue.cgRectValue

                self?.viewBottomConstraint.constant = keyboardFrame.size.height
                UIView.animate(withDuration: 0.5, animations :  {
                    self?.view.layoutIfNeeded()
                })

            }
        }
        tokens.append(token)
        
        token = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
            self?.viewBottomConstraint.constant = 0
            UIView.animate(withDuration: 0.5) {
                self?.view.layoutIfNeeded()
            }
        }
        tokens.append(token)
    }
    
    
}

extension ViewController : UITextFieldDelegate {
    
    
//    private func textFieldShouldBeginEditing(_ textField: UITextField){
//        UIView.setAnimationsEnabled(false)
//    }
    
    
    
    
    // False 를 리턴하면 문자가 입력되지도 않고 삭제되지도 않는다.
    // 허용된 문자를 입력할때는 true를 리턴해주고, 이상한 문자를 입력하면 false를 입력해준다.
//    1. 메소드를 호출한 텍스트필드가 전달된다.  2. 편집된 범위
//    3. 키보드에서 입력한 파라미터. (붙여넣기한것도 마지막 파라미터로)
//    문자를 삭제한 경우는 빈문자가 리턴된다.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.count > 0 {
            // 문자열에서, CharacterSet에 포함된 문자를 검색한다.
            guard string.rangeOfCharacter(from: charSet) == nil else {
                return false
            }
        }
        let finalText = NSMutableString(string: textField.text ?? "")
        finalText.replaceCharacters(in: range, with: string)
        let font = textField.font ?? UIFont.systemFont(ofSize: 16) // 폰트를 가져오고, 만약 폰트를 못가져오면 16포인트 기본폰트로 설정
        let dict = [NSAttributedString.Key.font : font]
        let textWidth = finalText.size(withAttributes: dict).width
        placeHolderLeadingConstraint.constant = textWidth
        if finalText.length == 0{
            placeHolder.text = "workspace-url.slack.com"
        }else {
            placeHolder.text = ".slack.com"
        }
        
        nextButton.isEnabled = finalText.length != 0
        return true
    }
}


