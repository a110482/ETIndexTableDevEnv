//
//  ViewController.swift
//  ETIndexTableDevEnv
//
//  Created by Elijah on 2021/7/1.
//

import UIKit
import SnapKit
import ETIndexTable

class ViewController: UIViewController {
    let dataTableViewController = MyETDataTableViewController()
    let indexTableViewController = MyETIndexTAbleViewcontroller()
    
    let demoModel = DemoModel.demoModel_1
    open var binder: ETIndexBinder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(dataTableViewController)
        view.addSubview(dataTableViewController.view)
        dataTableViewController.didMove(toParent: self)
        dataTableViewController.view.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.7)
        }
        dataTableViewController.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 700, right: 0)

        addChild(indexTableViewController)
        view.addSubview(indexTableViewController.view)
        indexTableViewController.didMove(toParent: self)
        indexTableViewController.view.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.right.equalToSuperview()
            $0.left.equalTo(dataTableViewController.view.snp.right)
        }

        dataTableViewController.demoModel = demoModel
        indexTableViewController.demoModel = demoModel

        binder = ETIndexBinder(
            indexTableViewController: indexTableViewController,
            dataTableViewController: dataTableViewController)
        
        var config = ETIndexBinderConfig()
        config.pagingBehaver = .withCellMedium
        binder?.setup(config: config)
    }
}


// MARK: - Data Table

class MyETDataTableViewController: ETDataTableViewController {
    var demoModel: [[String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MyCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInsetAdjustmentBehavior = .never
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return demoModel.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoModel[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = demoModel[indexPath.section][indexPath.row]
        cell?.selectionStyle = .none
        return cell!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - Index Table
class MyETIndexTAbleViewcontroller: ETIndexTableViewController {
    var demoModel: [[String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MyCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInsetAdjustmentBehavior = .never
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return demoModel.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(demoModel[section].count, 1)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = demoModel[indexPath.section][0]
        return cell!
    }
}


// MARK: - Cell
class MyCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor.lightGray
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor.gray
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
        self.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

