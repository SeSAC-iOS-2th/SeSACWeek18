//
//  ViewController.swift
//  SeSACWeek18
//
//  Created by 이중원 on 2022/10/31.
//

import UIKit

class ViewController: UIViewController {
    
    let api = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.profile()
        
    }
    

}

