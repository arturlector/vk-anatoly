//
//  AuthViewController.swift
//  vk-anatoly
//
//  Created by Artur Igberdin on 08.12.2021.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Oauth authorization (протокол)
        oauthRequestToGetToken()
        
        //TODO: - Memory Leak
        
//        for index in 1...UInt.max {
//            print(index)
//            let string = NSString(format: "\(index)" as NSString)
//        }
        
    }
    
    func oauthRequestToGetToken() {
        
        var urlComponents = URLComponents() //Конструктор URL
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7822904"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        //Запрос
        let request = URLRequest(url: urlComponents.url!)
        
        //Загружает запрос
        webView.load(request)
    }
    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy {
//
//    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html" else {
            decisionHandler(.allow)
            return
        }
        
        print(url)
        
    //https://oauth.vk.com/blank.html#access_token=f7f052c3579cd6eed51f405079c18a164ffb31f3483f065cfa3d8826bcfae752a116963f4ce391b4addb2&expires_in=86400&user_id=223761261
        
        //access_token=f7f052c3579cd6eed51f405079c18a164ffb31f3483f065cfa3d8826bcfae752a116963f4ce391b4addb2&expires_in=86400&user_id=223761261
        
        //[access_token, f7f052c3579cd6eed51f405079c18a164ffb31f3483f065cfa3d8826bcfae752a116963f4ce391b4addb2, expires_in, 86400, user_id, 223761261]
        
        let params = url.fragment?
            .components(separatedBy: "&")
            .map {$0.components(separatedBy: "=")}
            .reduce([String: String](), { result, item in
                
                var dict = result
                let key = item[0]
                let value = item[1]
                dict[key] = value
                return dict
            })
        
        guard let token = params?["access_token"], let userId = params?["user_id"] else { return }
        
        Session.shared.token = token
        Session.shared.userId = userId
        
        let friendsVC = FriendsViewController()
        navigationController?.pushViewController(friendsVC, animated: true)
        
        decisionHandler(.cancel)
        
    }

}
