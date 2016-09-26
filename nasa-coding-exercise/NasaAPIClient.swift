import Foundation

struct NasaAPIClientConstants {
  static let baseURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000"
  static let keyPath = "&api_key="
  static let clientID = "p9J6lAp6E3NYDDKh05UU6iuO2GsIpG7ukia79fUW"
}

struct NasaAPIClient {
  typealias Constants = NasaAPIClientConstants
  typealias APIResponse = (jsonData: [String: Any]?, error: Error?)
  
  func fetchJSON(completion: @escaping (APIResponse) -> ())  {
    let urlString = Constants.baseURL + Constants.keyPath + Constants.clientID
    guard let requestURL = URL(string: urlString) else {
      completion(APIResponse(jsonData: nil, error: nil))
      return
    }
    
    let session = URLSession.shared.dataTask(with: requestURL) { data, _, error in
      guard let reponseData = data, error == nil else {
        completion(APIResponse(jsonData: nil, error: error))
        return
      }
      
      do {
        let jsonData = try JSONSerialization.jsonObject(with: reponseData) as? [String: Any]
        completion(APIResponse(jsonData: jsonData, error: nil))
      } catch {
        completion(APIResponse(jsonData: nil, error: error))
      }
    }
    session.resume()
  }
  
}
