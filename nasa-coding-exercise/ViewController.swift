//
//  ViewController.swift
//  nasa-coding-exercise
//
//  Created by Michael Amundsen on 9/25/16.
//  Copyright © 2016 Michael Amundsen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let client = NasaAPIClient()

  override func viewDidLoad() {
    super.viewDidLoad()
    client.fetchJSON { jsonRepsonse in
      print(jsonRepsonse.jsonData)
      print(jsonRepsonse.error)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

