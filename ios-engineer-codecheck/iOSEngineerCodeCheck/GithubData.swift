 //
//  GithubData.swift
//  iOSEngineerCodeCheck
//
//  Created by 渡辺大智 on 2022/10/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

class GithubData {
    
    let notificationNameRepository = Notification.Name("getRepository")
    let notificationNameImage = Notification.Name("getImage")
    let notification = NotificationCenter.default

    var githubRepositories: [[String: Any]] = []
    var urlSessionTaskOfGithubData: URLSessionTask?
    var urlSessionTaskOfImage: URLSessionTask?
    var touchedCellIndex: Int?
    var touchedGithubRepository: [String: Any]?
    var gitAccountImage: UIImage?
    
    // URLSessionTaskを作成する
    func createURLSessionTaskOfGithubData(_ searchWord : String) {
        let repositoryURL = "https://api.github.com/search/repositories?q=\(searchWord)"
        guard let url = URL(string : repositoryURL) else {return}
        urlSessionTaskOfGithubData = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else {return}
            guard let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {return}
            guard let items = obj["items"] as? [[String: Any]] else {return}
            self?.githubRepositories = items
            self?.notification.post(name: self!.notificationNameRepository, object: nil)
        }
    }
    
    //アカウントの画像を読み込む
    func createURLSessionTaskOfImage() {
        guard let owner = githubRepositories[touchedCellIndex!]["owner"] as? [String: Any] else {return}
        guard let imgURL = owner["avatar_url"] as? String else {return}
        guard let url = URL(string : imgURL) else {return}
        urlSessionTaskOfImage = URLSession.shared.dataTask(with: url) { [weak self] (data, res, err) in
            guard let data = data else {return}
            guard let img = UIImage(data: data) else {return}
            print("画像URLセッションタスク作ったよ")
            self?.gitAccountImage = img
            print("gitAccountImageセット完了")
            self?.notification.post(name: self!.notificationNameImage, object: nil)
        }
    }

}
