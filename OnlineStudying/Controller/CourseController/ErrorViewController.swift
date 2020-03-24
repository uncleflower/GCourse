//
//  ErrorViewController.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/3/12.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    var errorStatus:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.text = "Error!(\(errorStatus ?? 200))"
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
