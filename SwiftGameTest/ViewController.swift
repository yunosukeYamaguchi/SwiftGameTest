//
//  ViewController.swift
//  SwiftGameTest
//
//  Created by student on 2024/12/09.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topBaseView: UIView!
    
    @IBOutlet weak var lifePointValueLabel: UILabel!
    @IBOutlet weak var comfyPointValueLabel: UILabel!
    @IBOutlet weak var favPointValueLabel: UILabel!
    
    @IBOutlet weak var bottomBaseView: UIView!
    
    @IBOutlet weak var eatButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var cleanButton: UIButton!
    
    @IBOutlet var characterImageView: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topViewSetup()
        bottomViewSetup()
    }

    /// TopViewのセットアップを行うメソッド
    func topViewSetup() {
        // 枠線の色を指定します
        topBaseView.layer.borderColor = UIColor.label.cgColor
        // 枠線の太さを指定します
        topBaseView.layer.borderWidth = 1.0
        // 角丸の指定を行います
        topBaseView.layer.cornerRadius = 25.0
        // 上側だけに角丸を付与する指定
        topBaseView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    /// BottomViewのセットアップを行うメソッド
    func bottomViewSetup() {
        // 枠線の色を指定します
        bottomBaseView.layer.borderColor = UIColor.label.cgColor
        // 枠線の太さを指定します
        bottomBaseView.layer.borderWidth = 1.0
        // 角丸の指定を行います
        bottomBaseView.layer.cornerRadius = 25.0
        // 上側だけに角丸を付与する指定
        bottomBaseView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }


}

