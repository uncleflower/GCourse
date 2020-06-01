//
//  CourseWebController.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/3/6.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import UIKit
import WebKit
import RealmSwift

class CourseWebController: UIViewController {
    var url: String = ""
    var spinner: UIActivityIndicatorView!
        
    var button = UIButton()
    
    //点击收藏的Url
    var urlStr = ""
    
    //圆圈的位置
    var startCenter = CGPoint.zero
    
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
        
        button.tintColor = .gray
        let rect = CGRect(x: 10, y: 55, width: 55, height: 55)
        button.frame = rect
        let image = UIImage(systemName: "smallcircle.circle.fill")
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(collect), for: .touchUpInside)
        button.alpha = 0.7
        view.addSubview(button)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(longPress:)))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(pan:)))
        button.addGestureRecognizer(pan)
        button.addGestureRecognizer(longPress)
        
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
    
    @objc func collect() {
        print("Pressed")
        
        guard status![0].isLoggedIn == true else {
            let alert = UIAlertController(title: "登录", message: "请登录后再收藏课程", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))

            present(alert, animated: true, completion: nil)

            return
        }
        
        let alert = UIAlertController(title: "你要收藏该页面吗", message: "你要收藏该页面吗，确定后该页面会被收藏在<我的学习>中", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "为该页面命名"
        }
        
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            let textField = alert.textFields![0]
            if textField.text!.isBlank {
                let error = UIAlertController(title: "错误", message: "命名不能为空！", preferredStyle: .alert)
                error.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                self.present(error, animated: true, completion: nil)
            } else {
                
                let course = Course()
                course.courseName = textField.text!
                course.url = self.urlStr
                course.account = status![0].currentAccount
                
                
                // 本地数据存储
                saveCourse(course: course)
                LCSaveCourse(LCCourse: course)
            }
            

            print("urlStr" + self.urlStr)
            
            
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func handlePan(pan: UIPanGestureRecognizer) {
        let translation = pan.translation(in: button.superview)
        
        if pan.state == .began {
            startCenter = button.center
        }
        
        if pan.state != .cancelled {
            button.center = CGPoint(x: startCenter.x + translation.x,y: startCenter.y + translation.y)
        }
    }
    
    @objc func handleLongPress(longPress: UILongPressGestureRecognizer) {
        if longPress.state == .began {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func getUrl() {
        //js注入，获得正在访问的页面的url
        self.webView.evaluateJavaScript("window.location.href") { (res, error) in
            if let res = res {
                print(res)
                self.urlStr = res as! String
            } else {
                print("none")
            }
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
    
//    获得正在访问的URL
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
//
//        if let urlStr = navigationAction.request.url?.absoluteString {
//            self.urlStr = urlStr
//
//        }
//        decisionHandler(.allow, .init())
//    }
    

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
        
        getUrl()
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

