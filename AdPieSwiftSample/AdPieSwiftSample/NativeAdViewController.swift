//
//  NativeAdViewController.swift
//  AdPieSwiftSample
//
//  Created by sunny on 2016. 10. 20..
//  Copyright © 2016년 GomFactory. All rights reserved.
//

import UIKit
import AdPieSDK

class NativeAdViewController: UIViewController, APNativeDelegate {
    
    var nativeAd: APNativeAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Slot ID 입력
        nativeAd = APNativeAd(slotId: "580491a37174ea5279c5d09b")
        // 델리게이트 등록
        nativeAd.delegate = self
        
        // 광고 요청
        nativeAd.load()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - APNative delegates
    
    func nativeDidLoad(_ nativeAd: APNativeAd!) {
        // 광고 요청 완료 후 이벤트 발생
        
        let nativeAdView = Bundle.main.loadNibNamed("AdPie_300x250_NativeAdView", owner: nil, options: nil)?[0] as! APNativeAdView
        view.addSubview(nativeAdView)
        
        var viewDictionary = [String: AnyObject]()
        viewDictionary["nativeAdView"] = nativeAdView
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[nativeAdView]|", options: [], metrics: nil, views: viewDictionary))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[nativeAdView]|", options: [], metrics: nil, views: viewDictionary))
        
        // 광고뷰에 데이터 표출
        nativeAdView.fillAd(nativeAd.getData())
        
        // 광고 클릭 이벤트 수신을 위해 등록
        nativeAd.registerView(forInteraction: nativeAdView)
        
    }
    
    func nativeDidFail(toLoad nativeAd: APNativeAd!, withError error: Error!) {
        // 광고 요청 실패 후 이벤트 발생
        // error code : error._code
        // error message : error.localizedDescription
        
        let errorMessage = "Failed to load native ads." + "(code : " + String(error._code) + ", message : " + error.localizedDescription + ")"
        
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        } else {
            let alertView = UIAlertView(title: "Error", message: errorMessage, delegate: nil, cancelButtonTitle: "OK")
            alertView.alertViewStyle = .default
            alertView.show()
        }

    }
    
    func nativeWillLeaveApplication(_ nativeAd: APNativeAd!) {
        // 광고 클릭 후 이벤트 발생
    }
}
