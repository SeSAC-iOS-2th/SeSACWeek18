//
//  ViewController.swift
//  SeSACWeek18
//
//  Created by 이중원 on 2022/10/31.
//

import UIKit
import RxSwift


class ViewController: UIViewController { //프로필
    
    let viewModel = ProfileViewModel()
    
    let disposeBog = DisposeBag()
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let phone = Phone()
        print(phone.numbers[2])
        print(phone[2])
        
        viewModel.profile // <Single>, Syntax Sugar
            .withUnretained(self)
            .subscribe { (vc, value) in
                vc.emailLabel.text = value.user.email
                vc.usernameLabel.text = value.user.username
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBog)
        
        // subscribe, bind, drive
        
        // driver vs signal
        
        viewModel.getProfile()
        
        checkCOW()
        
    }
    
    //값 타입 vs 참조 타입
    func checkCOW() {
        
        var test1 = "joong"
        address(&test1) //in out 매개변수
        
        //String의 Subscript
        print(test1[2])
        print(test1[200])
        
        var test2 = test1
        address(&test2)
        
        test2 = "sesac"
        
        address(&test1)
        address(&test2)
        
        var array = Array(repeating: "A", count: 100) //Array, Dictionary, Set == Collection ..CopyOnWrite 적용 (성능 최적화)
        address(&array)
        
        print(array[safe: 99])
        print(array[safe: 199])
        
        var newArray = array //실제로 복사 X, 원본을 공유 O !!
        address(&newArray)
        
        newArray[0] = "B" //값이 달라지는 순간에 복사 O => CopyOnWrite
        
        address(&array)
        address(&newArray)
    }
    
    func address(_ value: UnsafeRawPointer) {
        let address = String(format: "%p", Int(bitPattern: value))
        print(address)
    }

}

