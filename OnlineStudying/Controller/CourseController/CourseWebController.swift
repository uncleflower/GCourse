//
//  CourseWebController.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/3/6.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import UIKit
import WebKit

class CourseWebController: UIViewController {
    var url: String = ""
    var spinner: UIActivityIndicatorView!
    
    var webView: WKWebView!
    
    override func loadView() {
        
        let config = WKWebViewConfiguration()
        
        webView = WKWebView(frame: .zero, configuration: config)
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self
        webView.navigationDelegate = self //就是LoadDelegate
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSpinner()
        webView.load(URLRequest(url: URL(string: url)!))
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(pinch:)))
        view.addGestureRecognizer(pinch)
    }
    
    func setSpinner() {
        spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8012895976)
        spinner.layer.cornerRadius = 10
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: webView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: webView.centerYAnchor).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 80).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    @objc func handlePinch(pinch: UIPinchGestureRecognizer) {
        if pinch.state == .began || pinch.state == .changed {
            dismiss(animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CourseWebController:WKNavigationDelegate {
    //五个个生命周期函数
    
    //请求之前
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(#function)
        decisionHandler(.allow)
    }
    
    //开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
        spinner.startAnimating()
    }
    
    //接收到网站的响应之后
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print(#function)
        if let httpResponse = navigationResponse.response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                decisionHandler(.allow)
            }else{
                let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = sb.instantiateViewController(withIdentifier: "error") as! ErrorViewController
                vc.errorStatus = httpResponse.statusCode
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
                decisionHandler(.cancel)
            }
        }
    }
    
    //开始从服务器中接收数据
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(#function)
    }
    
    //结束接收
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(#function)
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
    
    //接收失败
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(#function)
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
}


extension CourseWebController: WKUIDelegate {
    
    //alert() 警告框
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) in
            completionHandler()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    //confirm() 确认框
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (_) in
            completionHandler(false)
        }))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) in
            completionHandler(true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    //prompt() 输入框
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = defaultText
        }
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) in
            completionHandler(alert.textFields?.last?.text)
        }))
        present(alert, animated: true, completion: nil)
    }
}
