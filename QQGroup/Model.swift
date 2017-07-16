//
//  Model.swift
//  QQGroup
//
//  Created by karl on 2017/07/16.
//  Copyright © 2017年 Karl. All rights reserved.
//

import UIKit
class Model: NSObject {
  var title: String
  var citys: [String]
  var index: Int
  var isOpen = false
  
  init(data: [String : Any]) {
    title = data["title"] as! String
    citys = data["cities"] as! [String]
    index = data["index"] as! Int
  }
}
