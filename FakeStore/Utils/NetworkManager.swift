//
//  NetworkManager.swift
//  FakeStore
//
//  Created by Aman Bhatt on 08/03/23.
//

import UIKit
import Foundation

class NetworkManager: NSObject {
    class var sharedInstance:NetworkManager {
        struct Singleton {
            static let instance = NetworkManager()
        }
        return Singleton.instance
        
    }
    func callingRequest( params: Dictionary<String,Any>,
                         apiname: String,
                         view: UIViewController,
                         requestType: HTTPMethods = .get,
                         taskCallback: @escaping (Result<Any, Error>) -> Void)  {
        
        let urlString  = BASEURL + "/" + apiname
        print("url",urlString)
        print("params", params)
        guard let url = URL(string: urlString) else{return}
        var urlRequest = URLRequest.init(url: url)
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        urlRequest.httpMethod = String(describing: requestType)
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            do{
                let parameterData = try JSONSerialization.data(withJSONObject:params, options:.prettyPrinted)
                urlRequest.httpBody = parameterData
            }catch{
            
            }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching data: \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(response)")
                return
            }
            if let objData = data,let httpResponse = response as? HTTPURLResponse{
                            
                            do{
                                let objResposeJSON = try JSONSerialization.jsonObject(with: objData, options: .mutableContainers)
                                if httpResponse.statusCode == 200{
                                   
                                    print("response:",objResposeJSON)
                                    taskCallback(.success(objResposeJSON))
                                }
                            }catch{
                                taskCallback(.failure(error))
                            }
                        }
           
            
        })
        task.resume()
        
    }
    
    func showHideActivityIndicator(viewController:UIViewController, action: Bool) {
        DispatchQueue.main.async {
            let activityView = UIActivityIndicatorView(style: .large)
            activityView.center = viewController.view.center
            
            
            if action{
                viewController.view.addSubview(activityView)
                activityView.isHidden = false
                activityView.startAnimating()
            }else{
                if (activityView != nil){
                    activityView.stopAnimating()
                    activityView.isHidden = true
                    viewController.view.willRemoveSubview(activityView)
                    }
                
            }
            
        }
    }
    
   
}
