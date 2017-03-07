import Foundation
import UIKit

protocol NasaPhotoDataStoreDelegate: class {
  func didLoadPhotoData(sender: NasaPhotoDataStore)
  func imageDidLoad(image: UIImage, indexPath: IndexPath)
}

class NasaPhotoDataStore {
  
  let apiClient = NasaAPIClient()
  var photoArray: [NasaPhoto] = []
  var photoDictionary = [IndexPath: UIImage]()
  var pendingRequests = [IndexPath: URLSession]()
  weak var delegate: NasaPhotoDataStoreDelegate?
  
  func getPhotoData() {
    apiClient.fetchJSON { [weak self] jsonRepsonse in
      guard let json = jsonRepsonse.jsonData?["photos"], let strongSelf = self else {
        return
      }
      
      for jsonDictionary in json {
        let newPhoto = NasaPhoto(json: jsonDictionary)
        if let newPhoto = newPhoto {
          self?.photoArray.append(newPhoto)
        }
      }
      
      DispatchQueue.main.async {
        self?.delegate?.didLoadPhotoData(sender: strongSelf)
      }
    }
  }
  
  func fetchImage(forIndex indexPath: IndexPath) {
    let nasaPhoto = photoArray[indexPath.row]
    pendingRequests[indexPath] = apiClient.fetchImage(imageURL: nasaPhoto.imageURL) { [weak self] data in
      self?.pendingRequests[indexPath] = nil
      guard let imageData = data, let image = UIImage(data: imageData) else {
        return
      }
      nasaPhoto.image = image
      self?.photoDictionary[indexPath] = image
      DispatchQueue.main.async {
        self?.delegate?.imageDidLoad(image: image, indexPath: indexPath)
      }
    }
  }
  
  func image(forIndexPath indexPath: IndexPath) -> UIImage? {
    if let image = photoDictionary[indexPath] {
      return image
    } else {
      fetchImage(forIndex: indexPath)
      return nil
    }
  }
  
  func cancelURLSession(forIndexPath indexPath: IndexPath) {
    guard let urlSession = pendingRequests[indexPath] else {
      return
    }
    urlSession.invalidateAndCancel()
    pendingRequests[indexPath] = nil
  }
  
}
