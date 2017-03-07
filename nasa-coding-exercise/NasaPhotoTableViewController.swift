import UIKit

struct NasaPhotoTableViewControllerConstants {
  static let cellResueIdentifier = "TableViewCell"
}

class NasaPhotoTableViewController: UITableViewController {
  typealias Constants = NasaPhotoTableViewControllerConstants
  
  let dataStore = NasaPhotoDataStore()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib.init(nibName: "NasaTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.cellResueIdentifier)
    dataStore.delegate = self
    dataStore.getPhotoData()
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataStore.photoArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellResueIdentifier, for: indexPath) as! NasaTableViewCell
    cell.imageView?.image = dataStore.image(forIndexPath: indexPath)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 300
  }
  
  override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    dataStore.cancelURLSession(forIndexPath: indexPath)
  }
}

extension NasaPhotoTableViewController: NasaPhotoDataStoreDelegate {
  func didLoadPhotoData(sender: NasaPhotoDataStore) {
    tableView.reloadData()
  }
  
  func imageDidLoad(image: UIImage, indexPath: IndexPath) {
    guard let visableIndexPaths = tableView.indexPathsForVisibleRows else {
      return
    }
    if visableIndexPaths.contains(indexPath) {
      tableView.reloadRows(at: [indexPath], with: .none)
    }
  }
}

