//
//  ViewController.swift
//  RxPlayground
//
//  Created by Andyy Hope on 24/08/2016.
//  Copyright © 2016 Andyy Hope. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class PersonsViewController: UIViewController, TableViewContainable {

    @IBOutlet var tableView: UITableView!
    
    var viewModel: PersonsViewModel = PersonsViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.requestTest(delay: 3)
        
        prepareTableView()
    }
    
    private func prepareTableView() {
        
        // Register Cells
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Cell Factory
        
        viewModel.persons.asObservable()
            .bindTo(tableView.rx_itemsWithCellFactory) { tableView, row, element in
                let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
                cell.textLabel?.text = element.name
                cell.detailTextLabel?.text = "\(element.age) years old"
                return cell
            }
            .addDisposableTo(disposeBag)
    }
}

