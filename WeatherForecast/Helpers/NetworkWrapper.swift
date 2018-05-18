//
//  NetworkWrapper.swift
//  WeatherForecast
//
//  Created by Ankit.G on 17/05/18.
//  Copyright © 2018 Ankit.Gohel. All rights reserved.
//

import UIKit

class NetworkWrapper: NSObject {

    //MARK: - API Calls
    func callAPI(with urlstring: String, onSuccess:@escaping (NSDictionary)->(), onFailure:@escaping (String)->()) {
        guard let url = URL(string: urlstring) else {
            DispatchQueue.main.async {
                onFailure(Constants.APIError)
            }
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { (responseData, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    onFailure(Constants.APIError)
                }
                return
            }
            guard let content = responseData else {
                DispatchQueue.main.async {
                    onFailure(Constants.APIError)
                }
                
                return
            }
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: [])) as? [String: Any] else {
                DispatchQueue.main.async {
                    onFailure(Constants.APIError)
                }
                return
            }
            if let status = json["status"] as? Int, status == 0,
                let message = json["message"] as? String {
                DispatchQueue.main.async {
                    onFailure(message)
                }
                
            } else {
                if JSONSerialization.isValidJSONObject(json) {
                    DispatchQueue.main.async {
                        onSuccess(json as NSDictionary)
                    }
                } else {
                    DispatchQueue.main.async {
                        onSuccess(NSDictionary())
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    
    func downloadImage(urlstring: String, onSuccess:@escaping (UIImage)->(), onFailure:@escaping (String)->()) {
        guard let url = URL(string: urlstring) else {
            DispatchQueue.main.async {
                onFailure(Constants.APIError)
            }
            return
        }
        
        let dataTask = URLSession.shared.downloadTask(with: url) { (responseURL, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    onFailure(Constants.APIError)
                }
                return
            }

            guard let content = responseURL else {
                DispatchQueue.main.async {
                    onFailure(Constants.APIError)
                }
                
                return
            }

            do {
                let imageData = try NSData(contentsOf: content, options: NSData.ReadingOptions())
                let _downloadedImage = UIImage(data: imageData as Data)
                
                DispatchQueue.main.async {
                    onSuccess(_downloadedImage!)
                }

            } catch {
                DispatchQueue.main.async {
                    onFailure(Constants.APIError)
                }
            }


            //5
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [_book3 setBackgroundImage: _downloadedImage forState:UIControlStateNormal];
//                [_scroller addSubview:_book3];
//                });

        }
        dataTask.resume()


    }

}
