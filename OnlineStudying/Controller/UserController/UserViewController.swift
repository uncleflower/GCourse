//
//  UserViewController.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/3/6.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import UIKit

class UserViewController: UITableViewController {
    @IBOutlet weak var headPortraitImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headPortraitImage.image = headImage
        userNameLabel.text = user.userName
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        headPortraitImage.image = headImage
        userNameLabel.text = user.userName
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 2 && indexPath.row == 0{
            
            guard status![0].isLoggedIn == true else {
                let alert = UIAlertController(title: "登录", message: "您还没登录呢", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            
            let alert = UIAlertController(title: "退出", message: "确定要退出登录吗？", preferredStyle: .alert)
            let yes = UIAlertAction(title: "确定", style: .destructive) { (_) in
                do {
                    try realm.write {
                        status![0].isLoggedIn = false
                        status![0].currentAccount = 0
                    }
                } catch {
                    print(error)
                }
                
                user = User()
                collections = realm.objects(Course.self).filter("account == 0")
                self.userNameLabel.text = user.userName
//                tableView.reloadData()
            }
            let no = UIAlertAction(title: "取消", style: .default, handler: nil)
            
            alert.addAction(yes)
            alert.addAction(no)
            
//            present(alert, animated: true, completion: nil)
            present(alert, animated: true) {
                tableView.reloadSections([0], with: .none)
            }
        }
        
        if indexPath.section == 0 && indexPath.row == 0 {
            guard status![0].isLoggedIn == false else {
                let alert = UIAlertController(title: "错误", message: "您已登录，请退出登录后再切换用户", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            
            let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let vc = sb.instantiateViewController(identifier: "logIn") as! LogInViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        if indexPath.section == 1 && indexPath.row == 2 {
            guard status![0].isLoggedIn == true else {
                let alert = UIAlertController(title: "登录", message: "您还没登录呢", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            
            let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let vc = sb.instantiateViewController(identifier: "changePwd") as! ChangePwdViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
