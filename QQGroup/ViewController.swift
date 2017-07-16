//
//  ViewController.swift
//  QQGroup
//
//  Created by karl on 2017/07/16.
//  Copyright © 2017年 Karl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var dataSource = [Model]() {
    didSet {
      tableView?.reloadData()
    }
  }
  var tableView: UITableView?
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView = UITableView(frame: view.bounds, style: .grouped)
    tableView?.delegate = self
    tableView?.dataSource = self
    view.addSubview(tableView!)
    
    parseData()
  }
  
  func tap(_ gesture: UITapGestureRecognizer) {
    if let header = gesture.view as? TableViewSectionHeaderView {
      let model = dataSource[header.section]
      model.isOpen = !model.isOpen
      let indexSet = IndexSet(integer: header.section)
      tableView?.reloadSections(indexSet, with: .fade)
    }
  }
  
  private func parseData() {
    guard let path = Bundle.main.path(forResource: "cityGroups", ofType: "plist") else { return }
    guard let array = NSArray(contentsOfFile: path) else { return }
    for element in array {
      if let item = element as? [String: Any] {
        let model = Model(data: item)
        dataSource.append(model)
      }
    }
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return dataSource.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let model = dataSource[section]
    return model.isOpen ? model.citys.count : 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    if cell == nil {
      cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
    cell?.textLabel?.text = dataSource[indexPath.section].citys[indexPath.row]
    return cell!
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    var header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? TableViewSectionHeaderView
    if header == nil {
      header = TableViewSectionHeaderView(reuseIdentifier: "header")
      header?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
    }
    header?.section = section
    header?.textLabel?.text = dataSource[section].title
    return header!
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 44
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 1e-10
  }
}


class TableViewSectionHeaderView: UITableViewHeaderFooterView {
  var section = 0
  private let lineView = UIView()
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    lineView.backgroundColor = UIColor.black
    contentView.addSubview(lineView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    lineView.frame = CGRect(x: 10, y: bounds.height - 1, width: bounds.width - 10, height: 1)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
