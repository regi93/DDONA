//
//  EmailViewController.swift
//  LoginUI
//
//  Created by 유준용 on 2021/05/26.
//

import UIKit

class EmailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func movePrev(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var titleBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextFeild: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextFeild.delegate = self
        // Do any additional setup after loading the view.
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
