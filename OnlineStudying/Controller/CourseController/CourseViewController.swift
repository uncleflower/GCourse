//
//  CourseViewController.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/3/6.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import UIKit


class CourseViewController: UITableViewController {
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(longPress:)))
        tableView.addGestureRecognizer(longPress)
        longPress.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return collections?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "course", for: indexPath) as! CourseCell
        if let collections = collections {
            cell.courseNameLabel.text = collections[indexPath.row].courseName
        } else {
            if status![0].isLoggedIn == true {
                cell.courseNameLabel.text = "开始添加一些页面吧"
            } else {
                cell.courseNameLabel.text = "请登录后再添加页面"
            }
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let collections = collections {
            let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = sb.instantiateViewController(identifier: COURSE_WEB) as! CourseWebController
            vc.modalPresentationStyle = .fullScreen
            vc.url = collections[indexPath.row].url
            present(vc, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        do {
            try realm.write {
                realm.delete(collections![indexPath.row])
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }

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

extension CourseViewController:UISearchBarDelegate,UIGestureRecognizerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        collections = realm.objects(Course.self).filter("courseName CONTAINS %@ AND account = \(status![0].currentAccount)",searchBar.text!).sorted(byKeyPath: "createdAT", ascending: false)

        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.isEmpty {
            collections = realm.objects(Course.self)
            tableView.reloadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    @objc func handleLongPress(longPress:UILongPressGestureRecognizer) {
        if longPress.state == .began {
            let pressLocation = longPress.location(in: tableView)
            if let pressIndexPath = tableView.indexPathForRow(at: pressLocation),let pressCell = tableView.cellForRow(at: pressIndexPath) as? CourseCell  {
                let alert = UIAlertController(title: "重命名", message: "你想更改该页面的名字为", preferredStyle: .alert)
                alert.addTextField { (textField) in
                    textField.placeholder = "为该页面重命名"
                }
                let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
                            let textField = alert.textFields![0]
                            if textField.text!.isBlank {
                                let error = UIAlertController(title: "错误", message: "命名不能为空！", preferredStyle: .alert)
                                error.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                                self.present(error, animated: true, completion: nil)
                            } else {
                                do {
                                    try realm.write {
                                        collections![pressIndexPath.row].courseName = textField.text!
                                    }
                                } catch {
                                    print(error)
                                }
                                pressCell.courseNameLabel.text = textField.text
                            }
                        }
                        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                        
                        alert.addAction(okAction)
                        alert.addAction(cancelAction)
                        
                        present(alert, animated: true, completion: nil)
                
            }
        }
    }
}
