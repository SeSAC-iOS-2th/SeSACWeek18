//
//  ViewController.swift
//  SeSACWeek18
//
//  Created by 이중원 on 2022/10/31.
//

import UIKit
import RxSwift
import RxAlamofire
import RxDataSources

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    //lazy var?
    lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: { datasource, tableView, indexPath, item in
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = "\(item)"
        return cell
    })
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testRxAlamofire()
        testRxDataSource()
        
    }
    
    func testRxDataSource() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].model
        }
        
        Observable.just([
            SectionModel(model: "첫번째 섹션", items: [1, 2, 3]),
            SectionModel(model: "두번째 섹션", items: [1, 2, 3]),
            SectionModel(model: "세번째 섹션", items: [1, 2, 3])
        ])
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
        
    }
    
    func testRxAlamofire() {
        //Success Or Error => <Single>
        let url = "https://api.unsplash.com/search/photos?query=apple";
        request(.get, url, headers: ["Authorization": "Client-ID 4RB3xKIv1jUJ2iuqNmbICVTbJ2xVp0WSPPh4zmmVvvY"])
            .data()
            .subscribe { value in
                print(value)
            }
            .disposed(by: disposeBag)
    }


}

