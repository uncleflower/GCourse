//
//  PageViewController.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/3/12.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    private lazy var VC1 = storyboard!.instantiateViewController(withIdentifier: "page1")
    private lazy var VC2 = storyboard!.instantiateViewController(withIdentifier: "page2")
    private lazy var VC3 = storyboard!.instantiateViewController(withIdentifier: "page3")
    private lazy var pages = [VC1,VC2,VC3]
    
    var pageControl: UIPageControl!
    var pendingIndex = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        setViewControllers([VC1], direction: .forward, animated: true, completion: nil)
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = pages.count
        view.addSubview(pageControl)

        let tap1 = UITapGestureRecognizer(target: self, action: #selector(handleTap1(tap:)))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(handleTap2(tap:)))
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(handleTap3(tap:)))

        VC1.view.addGestureRecognizer(tap1)
        VC2.view.addGestureRecognizer(tap2)
        VC3.view.addGestureRecognizer(tap3)
        
        delay(seconds: 2) {
            self.goToNextPage()
        }
        
    }
    
    
    
}

extension PageViewController: UIPageViewControllerDataSource{
    //向前翻页的话返回哪个VC
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let currentIndex = pages.firstIndex(of: viewController)!
 
        return currentIndex == 0 ? pages[2] : pages[currentIndex-1]
        
    }
    //向后翻页的话返回哪个VC
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.firstIndex(of: viewController)!
        return currentIndex == 2 ? pages[0] : pages[currentIndex+1]
    }
    
}

extension PageViewController: UIPageViewControllerDelegate{
    
    //即将过渡到下一页面的时候
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        //下一个页面在整个pages中的index
        pendingIndex = pages.firstIndex(of: pendingViewControllers[0])!
    }
    //已经完成动画（包括过渡完成和过渡取消）
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            pageControl.currentPage = pendingIndex
        }
    }
}

extension PageViewController {
    func delay(seconds: Double, completion: @escaping ()-> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
    
    func goToNextPage() {
        guard let currentViewController = self.viewControllers?.first else {return}
        guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }
        UIView.animate(withDuration: 2) {
            self.setViewControllers([nextViewController], direction: .forward, animated: false, completion: nil)
        }
        
        delay(seconds: 2) {
            self.goToNextPage()
        }
    }
}


extension PageViewController {
    
    @objc func handleTap1(tap:UITapGestureRecognizer) {
        if tap.state == .ended {
            let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let vc = sb.instantiateViewController(identifier: "courseWeb") as! CourseWebController
            vc.modalPresentationStyle = .fullScreen
            vc.url = "https://kaoyan.icourse163.org/course/terms/1451978488.htm?courseId=1451544229"
            present(vc, animated: true, completion: nil)
        }
    }
    @objc func handleTap2(tap:UITapGestureRecognizer) {
        if tap.state == .ended {
            let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let vc = sb.instantiateViewController(identifier: "courseWeb") as! CourseWebController
            vc.modalPresentationStyle = .fullScreen
            vc.url = "https://www.icourse163.org/live/view/480000001995601.htm?_trace_c_p_k2_=32cecccf433b4dd58c4abce716390a6d"
            present(vc, animated: true, completion: nil)
        }
    }
    @objc func handleTap3(tap:UITapGestureRecognizer) {
        if tap.state == .ended {
            let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let vc = sb.instantiateViewController(identifier: "courseWeb") as! CourseWebController
            vc.modalPresentationStyle = .fullScreen
            vc.url = "https://www.icourse163.org/topics/gongkaoKY_w"
            present(vc, animated: true, completion: nil)
        }
    }
}
