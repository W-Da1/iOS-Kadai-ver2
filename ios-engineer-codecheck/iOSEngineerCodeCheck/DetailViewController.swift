//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var languageLabel: UILabel?
    @IBOutlet weak var starsLabel: UILabel?
    @IBOutlet weak var watchersLabel: UILabel?
    @IBOutlet weak var forksLabel: UILabel?
    @IBOutlet weak var issuesLabel: UILabel?

    var githubData: GithubData!
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //scrollView.contentSize = contentView.frame.size
        scrollView.flashScrollIndicators()
        
        print("Detailに行ったよ")
        NotificationCenter.default.addObserver(self, selector: #selector(setImage(_:)), name:githubData.notificationNameImage, object: nil)
        githubData.createURLSessionTaskOfImage()
        
        let index = githubData.touchedCellIndex!
        let repository = githubData.githubRepositories[index]
        // ダークモードか否かによってテキストの色を動的に切り替える
        let dynamicColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return .white
            } else {
                return .black
            }
        }

        githubData.urlSessionTaskOfImage?.resume()
        titleLabel?.text = repository["full_name"] as? String
        titleLabel?.textColor = dynamicColor
        languageLabel?.text = "Written in \(repository["language"] as? String ?? "")"
        languageLabel?.textColor = dynamicColor
        starsLabel?.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        starsLabel?.textColor = dynamicColor
        watchersLabel?.text = "\(repository["watchers_count"] as? Int ?? 0) watchers"
        watchersLabel?.textColor = dynamicColor
        forksLabel?.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        forksLabel?.textColor = dynamicColor
        issuesLabel?.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        issuesLabel?.textColor = dynamicColor
        print("値の設定完了")
    }

}

extension DetailViewController {
    
    @objc func setImage(_ notification: Notification) {
        DispatchQueue.main.async {
            self.imageView?.image = self.githubData.gitAccountImage
        }
    }
    
}
