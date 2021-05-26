//
//  EmailViewController.swift
//  LoginUI
//
//  Created by 유준용 on 2021/05/26.
//

import UIKit

class EmailViewController: UIViewController {

    @IBOutlet weak var titleLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func movePrev(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var emailTextFeild: UITextField!
    var tokens = [NSObjectProtocol]()
    deinit {
        tokens.forEach{ NotificationCenter.default.removeObserver($0)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextFeild.becomeFirstResponder()
    }
    
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextFeild.delegate = self
        titleLabel.alpha = 0.0
        titleLabelBottomConstraint.constant = -20
        var token = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
            if let frameValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardFrame = frameValue.cgRectValue
                self?.viewBottomConstraint.constant = keyboardFrame.size.height
                UIView.animate(withDuration: 0.5) {
                    self?.view.layoutIfNeeded()
                }
            }
        }
        tokens.append(token)
        // Do any additional setup after loading the view.
        
        token = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
            UIView.animate(withDuration: 0.5) {
                self?.viewBottomConstraint.constant = 0
            }
            
        })
        tokens.append(token)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EmailViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField.text?.count ?? 0) > 0 {
            placeHolderLabel.alpha = 0.0
        } else{
            placeHolderLabel.alpha = 1.0
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let finalText = NSMutableString(string: textField.text ?? "")
        finalText.replaceCharacters(in: range, with: string)
        
        placeHolderLabel.alpha = finalText.length > 0 ? 0.0 : 1.0
        
        UIView.animate(withDuration: 0.3) {
            [weak self] in self?.titleLabel.alpha = finalText.length > 0 ? 1.0 : 0.0
            self?.titleLabelBottomConstraint.constant = finalText.length > 0 ? 0 : -20
            self?.view.layoutIfNeeded()
        }
        
        return true
    }
    
}
