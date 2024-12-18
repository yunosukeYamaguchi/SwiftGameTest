//
//  ViewController.swift
//  SwiftGameTest
//
//  Created by student on 2024/12/09.
//

import UIKit

class ViewController: UIViewController {
    
    var characterTask: Task<Void, Never>?
    
    var dateUpdateTask: Task<Void, Never>?
    
    @IBOutlet weak var topBaseView: UIView!
    
    @IBOutlet weak var lifePointValueLabel: UILabel!
    @IBOutlet weak var comfyPointValueLabel: UILabel!
    @IBOutlet weak var favPointValueLabel: UILabel!
    
    @IBOutlet weak var bottomBaseView: UIView!
    
    @IBOutlet weak var eatButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var cleanButton: UIButton!
    
    @IBOutlet var characterImageViews: [UIImageView]!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topViewSetup()
        bottomViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCharacterPosition()
        updateDateLabel()
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

    //キャラクター画像の位置の更新を開始する
    func updateCharacterPosition() {
        characterTask = Task {@MainActor in
            characterImageViews.forEach { view in
                view.image = nil
            }
            if let imageView = characterImageViews.randomElement() {
                imageView.image = UIImage(named: "CharacterDemoImage")
            }
            try? await Task.sleep(nanoseconds: 5 * 1000000000)
            updateCharacterPosition()
        }
    }
    
    func updateDateLabel() {
        dateUpdateTask = Task { @MainActor in
            let now = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .init(identifier: "ja_JP")
            dateFormatter.dateFormat = "MM/dd"
            dateLabel.text = dateFormatter.string(from: now)
            dateFormatter.dateFormat = "EEEE"
            dayOfWeekLabel.text = "(\(dateFormatter.string(from: now)))"
            try? await Task.sleep(nanoseconds: 60 * 60 * 1000000000)
            updateDateLabel()
        }
    }
}

