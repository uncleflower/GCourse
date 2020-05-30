//
//  StudyCenterViewController.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/3/27.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import UIKit

class StudyCenterViewController: UIViewController {
    @IBOutlet weak var mooc: UIStackView!
    @IBOutlet weak var bilibili: UIStackView!
    @IBOutlet weak var csdn: UIStackView!
    @IBOutlet weak var github: UIStackView!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var jiaoben: UIStackView!
    @IBOutlet weak var xuexi: UIStackView!
    @IBOutlet weak var maizi: UIStackView!
    @IBOutlet weak var jike: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(yourWeb(tap:)))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(yourWeb(tap:)))
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(yourWeb(tap:)))
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(yourWeb(tap:)))
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(yourWeb(tap:)))
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(yourWeb(tap:)))
        let tap7 = UITapGestureRecognizer(target: self, action: #selector(yourWeb(tap:)))
        let tap8 = UITapGestureRecognizer(target: self, action: #selector(yourWeb(tap:)))
        let tap9 = UITapGestureRecognizer(target: self, action: #selector(yourWeb(tap:)))

        mooc.addGestureRecognizer(tap1)
        bilibili.addGestureRecognizer(tap2)
        csdn.addGestureRecognizer(tap3)
        github.addGestureRecognizer(tap4)
        stack.addGestureRecognizer(tap5)
        jiaoben.addGestureRecognizer(tap6)
        xuexi.addGestureRecognizer(tap7)
        maizi.addGestureRecognizer(tap8)
        jike.addGestureRecognizer(tap9)
        
    }
    
    @objc func yourWeb(tap:UITapGestureRecognizer) {
        
        if let stackView = tap.view {
            let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = sb.instantiateViewController(identifier: COURSE_WEB) as! CourseWebController
            
            if stackView.restorationIdentifier == "mooc" {
                vc.url = "https://www.icourse163.org"
//                vc.url = "http://www.icourses.cn/home/"
            } else if stackView.restorationIdentifier == "bilibili" {
                vc.url = "https://www.bilibili.com"
            } else if stackView.restorationIdentifier == "csdn" {
                vc.url = "https://www.csdn.net"
            } else if stackView.restorationIdentifier == "github" {
                vc.url = "https://github.com"
            } else if stackView.restorationIdentifier == "stack" {
                vc.url = "https://stackoverflow.com"
            } else if stackView.restorationIdentifier == "jiaoben" {
//                vc.url = "https://www.jb51.net"
                vc.url = "https://ke.qq.com"
            } else if stackView.restorationIdentifier == "xuexi" {
                vc.url = "http://www.xuexi365.com"
            } else if stackView.restorationIdentifier == "maizi" {
                vc.url = "https://study.163.com/provider/470451/index.htm"
            } else if stackView.restorationIdentifier == "jike" {
//                vc.url = "https://www.jikexueyuan.com"
                vc.url = "https://study.163.com"
            }
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        
    }
}
