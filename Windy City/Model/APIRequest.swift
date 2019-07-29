//
//  RequestBuilder.swift
//  Windy City
//
//  Created by Rory Prior on 14/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import Foundation

class APIRequest {

  func sendRequest(URL: URL!, params : Dictionary<String,String>!, method: String,completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
    
    guard URL != nil else {return}
    
    let sessionConfig = URLSessionConfiguration.default
    
    /* Create session, and optionally set a URLSessionDelegate. */
    let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
    
    var request = URLRequest(url: URL.appendingQueryParameters(params))
    request.httpMethod = method
    
    /* Start a new Task */
    let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
      if (error == nil) {
        // Success
        let statusCode = (response as! HTTPURLResponse).statusCode
        if(statusCode == 200) {
          completion(data, nil)
          return
        }
        else {
          // Unexpected status code
          print("Unexpected status code: \(statusCode)")
          let responseError = NSError(code: statusCode, message: "Unexpected status code \(statusCode)")
          completion(nil, responseError) // we won't return JSON because the calling function may not be getting what it asked for
        }
      }
      else {
        // Failure
        print("URL Session Task Failed: %@", error!.localizedDescription);
        completion(nil, error)
      }
    })
    task.resume()
    session.finishTasksAndInvalidate()
  }
}

protocol URLQueryParameterStringConvertible {
  var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
  /**
   This computed property returns a query parameters string from the given NSDictionary. For
   example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
   string will be @"day=Tuesday&month=January".
   @return The computed parameters string.
   */
  var queryParameters: String {
    var parts: [String] = []
    for (key, value) in self {
      let part = String(format: "%@=%@",
                        String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                        String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
      parts.append(part as String)
    }
    return parts.joined(separator: "&")
  }
  
}

extension URL {
  /**
   Creates a new URL by adding the given query parameters.
   @param parametersDictionary The query parameter dictionary to add.
   @return A new URL.
   */
  func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
    let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
    return URL(string: URLString)!
  }
}

extension NSError {
  convenience init(code: Int, message: String) {
    self.init(domain: Bundle.main.bundleIdentifier ?? "", code: code, userInfo: [NSLocalizedDescriptionKey: message])
  }
}
