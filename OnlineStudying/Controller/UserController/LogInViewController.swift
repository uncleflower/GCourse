//
//  LogInViewController.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/3/6.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import UIKit
import RealmSwift
import LeanCloud

protocol ChangeUsernameDeletage {
    func didChangeUsername(username:String)
}

class LogInViewController: UIViewController {
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var iconImage = UIImageView()
    
    var deletage: ChangeUsernameDeletage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setIconImage()
    }
    
    @objc func dismissKeyboard() {
        self.accountTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    @IBAction func logInButton(_ sender: UIButton) {
        
        let account = accountTextField.text ?? " "
        let password = passwordTextField.text ?? " "
        
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
        
        let isExistInLC = LCQueryUser(account: Int(account) ?? -1,password: password)
        

//        users = realm.objects(User.self).filter("account = \(account)")
        
        guard isExistInLC != 0 else {
            let alert = UIAlertController(title: "错误", message: "账号或密码错误", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .destructive, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
//        user = users![0]
        
        do {
            try realm.write {
                status![0].isLoggedIn = true
                status![0].currentAccount = Int(account)!
            }
        } catch {
            print(error)
        }
        
        LCQueryCourse(account: Int(account) ?? -1 )
        collections = realm.objects(Course.self).filter("account = \(account)")
        
        
        self.dismiss(animated: true) {
            
            if status![0].isLoggedIn == true {
                users = realm.objects(User.self).filter("account = \(status![0].currentAccount)")
                user = users![0]
                
                self.deletage?.didChangeUsername(username: user.userName)
            }
        }
        
    }
    
    @IBAction func disMissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func signUpButton(_ sender: UIButton) {
        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(identifier: "signUp") as! SignUpViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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

extension LogInViewController {
    
    func setIconImage() {
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
    }
    
}
