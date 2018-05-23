//
//  ATableViewController.swift
//  CellCollapse
//
//  Created by Aleksander Maj on 22/05/2018.
//  Copyright © 2018 HTD. All rights reserved.
//

import UIKit

class ATableViewController: UITableViewController {
        
    var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Expand/Collapse"
        tableView.tableFooterView = UIView()

        let viewController = UIViewController()
        let sc = UISearchController.init(searchResultsController: viewController)
        sc.searchResultsUpdater = nil

        if #available(iOS 11.0, *) {
            navigationItem.searchController = sc
        }
        definesPresentationContext = true
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)

        let cellNib = UINib(nibName: ATableViewCell.nibName, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: ATableViewCell.reuseId)
        let headerNib = UINib(nibName: SectionHeaderView.nibName, bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: SectionHeaderView.reuseId)

        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        navigationItem.rightBarButtonItem = rightBarButtonItem

        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATableViewCell.reuseId, for: indexPath) as! ATableViewCell

        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor(white: 0.975, alpha: 1.0) : UIColor(white: 0.95, alpha: 1.0)
        cell.indexLabel.text = "\(indexPath.row)"
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow(at: indexPath)
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow(at: indexPath)
    }

    private func heightForRow(at indexPath: IndexPath) -> CGFloat {
        var height: CGFloat
        if selectedIndexPath == indexPath {
            height = 300 + CGFloat((indexPath.row % 4) * 20)
        } else {
            height = 70
        }
        return height
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.reuseId)
        return hv
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        var expandIndexPath: IndexPath?

        if selectedIndexPath == indexPath {
            expandIndexPath = nil
        } else {
            expandIndexPath = indexPath
        }

        expandRow(at: expandIndexPath)

    }

    func expandRow(at indexPath: IndexPath?) {
        selectedIndexPath = indexPath
        tableView.beginUpdates()
        tableView.endUpdates()

        if let ip = indexPath {
            tableView.scrollToRow(at: ip, at: .none, animated: true)
        }
    }

    @objc func refresh() {
        refreshControl?.endRefreshing()
    }
}
