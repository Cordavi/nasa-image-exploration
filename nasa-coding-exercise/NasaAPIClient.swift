import Foundation

struct NasaAPIClientConstants {
  static let baseURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000"
  static let keyPath = "&api_key="
  //WARNING: INSERT YOUR NASA API KEY HERE
  static let clientID = "INSERT YOUR KEY HERE"
}

struct NasaAPIClient {
  typealias Constants = NasaAPIClientConstants
  typealias APIResponse = (jsonData: [String: [[String: Any]]]?, error: Error?)
  
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
        let jsonData = try JSONSerialization.jsonObject(with: reponseData) as? [String: [[String: Any]]]
        completion(APIResponse(jsonData: jsonData, error: nil))
      } catch {
        completion(APIResponse(jsonData: nil, error: error))
      }
    }
    session.resume()
  }
  
  func fetchImage(imageURL: URL, completion: @escaping (Data?) -> ()) -> URLSession {
    let session = URLSession(configuration: .default)
      let dataTaskSession = session.dataTask(with: imageURL) { data, response, error in
        guard let responseData = data, error == nil else {
          completion(nil)
          return
        }
        completion(responseData)
    }
    dataTaskSession.resume()
    return session
  }
  
}
