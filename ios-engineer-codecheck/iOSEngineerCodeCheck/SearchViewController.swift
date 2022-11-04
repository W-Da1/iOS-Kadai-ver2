//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//
import Foundation
import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var githubData = GithubData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableViewにてdequeueReusableCellを使うように設定
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        searchBar.placeholder = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable(_:)), name:githubData.notificationNameRepository, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let detail = segue.destination as! DetailViewController
            detail.githubData = githubData
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubData.githubRepositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let repository = githubData.githubRepositories[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        githubData.touchedCellIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }

}

extension SearchViewController {

    @objc func reloadTable(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}

extension SearchViewController {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        githubData.urlSessionTaskOfGithubData?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //print("ボタンは押してるよ")
        guard let searchWord = searchBar.text else {return}
        if !searchWord.isEmpty {
            githubData.createURLSessionTaskOfGithubData(searchWord)
            //print("URLセッションタスクは作ったよ")
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                // これ呼ばなきゃリストが更新されません
                self?.githubData.urlSessionTaskOfGithubData?.resume()
            }
        }
    }

}
    

