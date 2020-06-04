//
//  ChangePwdViewController.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/5/30.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import UIKit

class ChangePwdViewController: UIViewController {
    
    @IBOutlet weak var oldPwd: UITextField!
    @IBOutlet weak var newPwd: UITextField!
    @IBOutlet weak var confirmPwd: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.oldPwd.resignFirstResponder()
        self.newPwd.resignFirstResponder()
        self.confirmPwd.resignFirstResponder()
    }
    
    
    @IBAction func confirmButton(_ sender: UIButton) {
        let oldPassword = oldPwd.text ?? " "
        let newPassword = newPwd.text ?? " "
        let confirmPassword = confirmPwd.text ?? " "
        
        guard !oldPassword.isBlank && !newPassword.isBlank && !confirmPassword.isBlank else {
            let alert = UIAlertController(title: "错误", message: "输入不能为空", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard oldPassword == user.password else {
            let alert = UIAlertController(title: "错误", message: "密码错误", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard newPassword == confirmPassword else {
            let alert = UIAlertController(title: "错误", message: "两次密码输入不同", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard oldPassword != newPassword else {
            let alert = UIAlertController(title: "错误", message: "新密码不能与旧密码相同", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        users = realm.objects(User.self).filter("account == \(status![0].currentAccount)")
        
        updatePassword(user: users![0], newPassword: newPassword)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
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
