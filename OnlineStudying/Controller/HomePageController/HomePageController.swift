//
//  HomePageController.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/3/11.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import UIKit

class HomePageController: UITableViewController {
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 2 {
            goWeb(row: indexPath.row)
        }
        
    }
    
    func goWeb(row: Int) {
        
        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(identifier: COURSE_WEB) as! CourseWebController
        
        switch row {
        case 0: vc.url = "https://www.icourse163.org/course/BIT-47004"
        case 1: vc.url = "https://www.icourse163.org/course/HIT-7001"
        case 2: vc.url = "https://www.icourse163.org/course/ZJU-1206632831"
        case 3: vc.url = "https://www.icourse163.org/course/ZJU-1003377027"
        default: vc.url = "https://www.icourse163.org/course/HIT-1206320802"
        }
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}
