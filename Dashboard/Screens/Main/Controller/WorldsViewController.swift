//
//  WorldsViewController.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/6/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

protocol IWorldsViewControllerDelegate: class {
    func worldsDataProvider() -> DataProvider<IWorldsDatasource>
    func didSelect(aWorld:WorldItem, at index:IndexPath)
}

class WorldsViewController: UIViewController {

    // MARK: Vars
    
    @IBOutlet weak var tableView:UITableView!
    weak var delegate: IWorldsViewControllerDelegate!
    var datasource: IWorldsDatasource? {
        didSet {
            if datasource == nil {
                error_impossibleCondition("datasource can't be nil")
            }
            self.registerReusableViews()
            self.tableView.reloadData()
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "worlds.title".localized
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
        let dataProvider = delegate.worldsDataProvider()
        showLoading()
        dataProvider.loadData { (success, datasource, error) in
            self.showLoading(false)
            if !success {
                self.showAlert(message: "worlds.networkd.dataFailed".localized +
                    (error?.localizedDescription ?? ""))
                return
            }
            
            self.datasource = datasource
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}


// MARK: Table view

extension WorldsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource?.models.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = datasource!.models[indexPath.row]
        if let cell = tableView
            .dequeueReusableCell(withIdentifier: model.nibName) as? WorldViewCell {
            cell.configureWith(world: model)
            return cell
        }
        
        error_impossibleCondition("WorldViewCell is required")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate.didSelect(aWorld: datasource!.item(at: indexPath), at: indexPath)
    }
    
    func registerReusableViews() {
        for model in datasource!.models {
            let nib = UINib(nibName: model.nibName, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: model.nibName)
        }
    }
}
