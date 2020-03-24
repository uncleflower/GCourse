//
//  LogInViewController.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/3/6.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        self.accountTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    @IBAction func logInButton(_ sender: UIButton) {
        //TODO:检查账号密码是否正确，若正确用dimiss 然后最后的completion设置user属性，若错误就用alert提示用户
    }
    @IBAction func disMissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
