//
//  NasaPhoto.swift
//  nasa-coding-exercise
//
//  Created by Michael Amundsen on 9/25/16.
//  Copyright © 2016 Michael Amundsen. All rights reserved.
//

import UIKit

class NasaPhoto {
  let imageURL: URL
  let created: Date?
  var image: UIImage?
  
  init?(json: [String: Any]) {
    guard let imageURLString = json["img_src"] as? String, let url = URL(string: imageURLString) else {
      return nil
    }
    imageURL = url
    
    let dateString = json["earth_date"] as? String
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    created = dateFormatter.date(from: dateString ?? "")
  }
}

