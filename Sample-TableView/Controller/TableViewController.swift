//
//  TableViewController.swift
//  Sample-TableView
//
//  Created by 渡邊魁優 on 2023/03/29.
//

import UIKit
import Kingfisher

class TableViewController: UITableViewController {
    private var items: [Article] = []
    let articlesAPIClient = ArticleAPIClient()
    let indicatotor = UIActivityIndicatorView()
    var sampleImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //インジケータースタート
        indicatotor.style = UIActivityIndicatorView.Style.large
        indicatotor.center = self.view.center
        self.view.addSubview(indicatotor)
        indicatotor.startAnimating()
        
        Task {
            await loadArticle()
        }
    }
    
    //Section（ない場合は1が帰る）
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    //cellの行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    //cellの生成
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

//        var configulation = cell.defaultContentConfiguration()
//        configulation.text = items[indexPath.row].title
//        cell.contentConfiguration = configulation
        
        cell.textLabel?.text = items[indexPath.row].title
        cell.imageView?.kf.setImage(with: items[indexPath.row].user.profileImageURL)
        
        return cell
    }
    
    private func loadArticle() async {
        do {
            let articles = try await articlesAPIClient.fetchArticles()
            DispatchQueue.main.async {
                self.indicatotor.stopAnimating()
                self.items = articles
                self.tableView.reloadData()
            }
        } catch {
            let error = error as? APIError ?? APIError.unknown
            print(error.title)
        }
    }
}
