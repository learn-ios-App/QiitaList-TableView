//
//  TableViewController.swift
//  Sample-TableView
//
//  Created by 渡邊魁優 on 2023/03/29.
//

import UIKit

class TableViewController: UITableViewController {
    private var items: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await loadArticle()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        var configulation = cell.defaultContentConfiguration()
        configulation.text = items[indexPath.row].title
        cell.contentConfiguration = configulation
        
        return cell
    }
    
    private func loadArticle() async {
        let articlesAPIClient = ArticleAPIClient()
        do {
            let articles = try await articlesAPIClient.fetchArticles()
            DispatchQueue.main.async {
                self.items = articles
                self.tableView.reloadData()
            }
        } catch {
            let error = error as? APIError ?? APIError.unknown
            print(error.title)
        }
    }
}
