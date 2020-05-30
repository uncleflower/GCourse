//
//  SignUpViewController.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/5/26.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    let iconImage = UIImageView()
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBAction func beginAnimation(_ sender: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.iconImage.alpha = 0
            self.topConstraint.constant = 100
        }
        view.layoutIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
//        iconImage2.frame.size.width = 215
//        iconImage2.frame.size.height = 215
        
        iconImage.layer.masksToBounds = true
        iconImage.layer.cornerRadius = 15
        iconImage.contentMode = .scaleAspectFill
        iconImage.image = UIImage(named: "logo.png")
        view.addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        

        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        self.userNameTextField.resignFirstResponder()
        self.accountTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        
        UIView.animate(withDuration: 0.5) {
            self.iconImage.alpha = 1
            self.topConstraint.constant = 350
        }
        view.layoutIfNeeded()
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        
        let userName = userNameTextField.text ?? " "
        let account = accountTextField.text ?? " "
        let password = passwordTextField.text ?? " "
        
        guard !userName.isBlank else {
            let alert = UIAlertController(title: "错误", message: "昵称不能为空", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .destructive, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        guard !account.isBlank else {
            let alert = UIAlertController(title: "错误", message: "账号不能为空", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .destructive, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        guard !password.isBlank else {
            let alert = UIAlertController(title: "错误", message: "密码不能为空", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .destructive, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let isAccountExist = realm.objects(User.self).filter("account = \(account)")
        
        guard isAccountExist.count == 0 else {
            let alert = UIAlertController(title: "错误", message: "账号重复，请设置其他账号", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .destructive, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let newUser = User()
        newUser.userName = userName
        newUser.account = Int(account)!
        newUser.password = password
        
        saveUser(user: newUser)
        
        let alert = UIAlertController(title: "成功", message: "注册成功！", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "好的", style: .default, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
        
        
                
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
