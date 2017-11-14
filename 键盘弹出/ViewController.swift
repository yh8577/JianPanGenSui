//
//  ViewController.swift
//  键盘弹出
//
//  Created by yihui on 2017/11/14.
//  Copyright © 2017年 yihui. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var v: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var u1: UITextField!
    @IBOutlet weak var u2: UITextField!
    
    var Frame : CGRect!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        u1.delegate = self
        u2.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.kbFrameChanged(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
    }
    

    //MARK: -- 获取当前被选择的UITextField
    func textFieldDidBeginEditing(_ textField: UITextField) {
        Frame = textField.frame
    }
    
    //MARK: -- Return 关闭键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    //MARK: --<#name> 弹出键盘上移UI
    @objc private func kbFrameChanged( _ notification : Notification) {
        
        let info = notification.userInfo
        let kbRect = (info?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let bottomSpacing: CGFloat = 50
        let maxY = view.frame.height - (Frame.maxY + bottomSpacing)
        let offset : CGFloat = maxY - kbRect.height
        let offsetY : CGFloat = (kbRect.origin.y < view.frame.height) ? offset : 0
        if (kbRect.height) > (view.bounds.height-Frame.maxY) {
            UIView.animate(withDuration: 0.3) {
                self.v.transform = CGAffineTransform(translationX: 0, y: offsetY)
            }
        }
    }
    
    //MARK: -- 关闭空白处关闭键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

