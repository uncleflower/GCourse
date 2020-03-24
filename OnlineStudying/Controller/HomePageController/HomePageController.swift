//
//  HomePageController.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/3/11.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import UIKit

class HomePageController: UITableViewController {
    @IBOutlet weak var mooc: UIImageView!
    @IBOutlet weak var bilibili: UIImageView!
    @IBOutlet weak var csdn: UIImageView!
    @IBOutlet weak var github: UIImageView!
    @IBOutlet weak var stack: UIImageView!
    @IBOutlet weak var jiaoben: UIImageView!
    @IBOutlet weak var xuexi: UIImageView!
    @IBOutlet weak var maizi: UIImageView!
    @IBOutlet weak var jike: UIImageView!
    
    
    @IBAction func moocTap(_ sender: Any) {
        print("tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        let tap = UITapGestureRecognizer(target: self, action: #selector(yourWeb(tap:)))
        mooc.addGestureRecognizer(tap)
        bilibili.addGestureRecognizer(tap)
        csdn.addGestureRecognizer(tap)
        github.addGestureRecognizer(tap)
        stack.addGestureRecognizer(tap)
        jiaoben.addGestureRecognizer(tap)
        xuexi.addGestureRecognizer(tap)
        maizi.addGestureRecognizer(tap)
        jike.addGestureRecognizer(tap)
        
    }
    
    @objc func yourWeb(tap:UITapGestureRecognizer) {
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(identifier: "courseWeb") as! CourseWebController
        if let imageView = tap.view {
            if imageView.tag == 0 {
                vc.url = "https://www.icourse163.org"
            }else if imageView.tag == 1 {
                vc.url = "https://www.bilibili.com"
            }else if imageView.tag == 2 {
                vc.url = "https://www.csdn.net"
            }else if imageView.tag == 3 {
                vc.url = "https://github.com"
            }else if imageView.tag == 4 {
                vc.url = "https://stackoverflow.com"
            }else if imageView.tag == 5 {
                vc.url = "https://www.jb51.net"
            }else if imageView.tag == 6 {
                vc.url = "http://www.xuexi365.com"
            }else if imageView.tag == 7 {
                vc.url = "https://study.163.com/provider/470451/index.htm"
            }else if imageView.tag == 8 {
                vc.url = "https://www.jikexueyuan.com"
            }
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        print("tapped")
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
