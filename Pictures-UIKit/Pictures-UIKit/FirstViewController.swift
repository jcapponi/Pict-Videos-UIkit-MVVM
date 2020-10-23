//
//  FirstViewController.swift
//  Pictures-UIKit
//
//  Created by Juan Capponi on 9/21/20.
//  Copyright © 2020 Juan Capponi. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var viewModelDataSource: ViewModelDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Photos"
        
        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        viewModelDataSource = ViewModelDataSource()
        viewModelDataSource.pictRetrieve()
        binding()
    }

    private func binding() {
        self.activity.startAnimating()
           viewModelDataSource.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                   self?.tableView.reloadData()
                   self?.activity.stopAnimating()
                   self?.activity.isHidden = true
               }
           }
       }
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModelDataSource.photosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cellIdentifier, for: indexPath) as! CustomTableViewCell
        
        let model = viewModelDataSource.photosArray[indexPath.row]
        let viewModel = CellViewModelPictures.init(photographerName: model.photographer, urlSmall: model.src.small, medium: model.src.medium)
        cell.configue(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModelDataSource.photosArray[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "storyPictureVC") as! PictureViewController
        vc.name = model.photographer
        vc.url = model.src.medium
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constants.customViewCellHeigth)
    }
}
