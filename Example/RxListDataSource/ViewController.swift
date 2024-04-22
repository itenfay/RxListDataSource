//
//  ViewController.swift
//  RxListDataSource
//
//  Created by Teng Fei on 04/14/2024.
//  Copyright (c) 2024 Teng Fei. All rights reserved.
//

import UIKit
import RxListDataSource
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController, CXTableViewDataSourceProvidable {
    
    typealias S = TableSectionEntity
    typealias T = PermissionModel
    
    private var tableView: UITableView!
    private let disposeBag = DisposeBag()
    
    private let viewModel = RootViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        bind()
        viewModel.loadData()
    }
    
    func makeUI() {
        let safeTop = UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 88.0
        tableView = UITableView(frame: self.view.bounds)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = UIEdgeInsets(top: safeTop + 10, left: 0, bottom: 10, right: 0)
        view.addSubview(tableView)
    }
    
    func bind() {
        viewModel.items.bind(to: tableView.rx.items(dataSource: provideAnimatedDataSource())).disposed(by: disposeBag)
        tableView.rx.itemSelected.asDriver().drive(onNext: { [weak self] indexPath in
            self?.itemDidSelect(at: indexPath)
        }).disposed(by: disposeBag)
    }
    
    func configureCell(tv tableView: UITableView, indexPath: IndexPath, item: PermissionModel) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PermissionCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "PermissionCell")
        }
        cell?.selectionStyle = .none
        cell?.accessoryType = .disclosureIndicator
        
        item.type.map({"权限--" + $0.description + ": "}).bind(to: cell!.textLabel!.rx.text).disposed(by: disposeBag)
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        cell?.textLabel?.textColor = UIColor(red: 51.0/255, green: 51.0/255, blue: 51.0/255, alpha: 1)
        item.status.map({"授权状态: " + $0.description}).bind(to: cell!.detailTextLabel!.rx.text).disposed(by: disposeBag)
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        cell?.detailTextLabel?.textColor = UIColor(red: 102.0/255, green: 102.0/255, blue: 102.0/255, alpha: 1)
        
        return cell!
    }
    
    func itemDidSelect(at indexPath: IndexPath) {
        let tableSectionEntity = viewModel.items.value[indexPath.section]
        let permissionModel: PermissionModel = tableSectionEntity.items[indexPath.item]
        print("[I] row-\(indexPath.row): did click! \(permissionModel.type.value): \(permissionModel.status.value)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
