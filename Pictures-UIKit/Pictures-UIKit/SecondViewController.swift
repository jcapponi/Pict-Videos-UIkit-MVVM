//
//  SecondViewController.swift
//  Pictures-UIKit
//
//  Created by Juan Capponi on 9/21/20.
//  Copyright © 2020 Juan Capponi. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class SecondViewController: UIViewController {

 @IBOutlet weak var tableView: UITableView!
        
 @IBOutlet weak var activity: UIActivityIndicatorView!
        
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
        var viewModelDataSource: ViewModelDataSource!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.navigationItem.title = "Videos"
            
            tableView.register(CustomVideoViewCell.nib(), forCellReuseIdentifier: CustomVideoViewCell.cellIdentifier)
            
            tableView.delegate = self
            tableView.dataSource = self
            
            viewModelDataSource = ViewModelDataSource()
            viewModelDataSource.videosRetrieve()
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

    extension SecondViewController: UITableViewDelegate, UITableViewDataSource  {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            viewModelDataSource.videosArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomVideoViewCell.cellIdentifier, for: indexPath) as! CustomVideoViewCell
            
            let model = viewModelDataSource.videosArray[indexPath.row]
            let viewModel = CellViewModelMovies.init(videoCreatorName: model.user.name , quality: model.video_files[1].quality, link: model.video_files[1].link ,  imgageUrl: model.image)
            cell.configueVideo(with: viewModel)
            return cell
        }
      
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            playVideo(at: indexPath)
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return CGFloat(Constants.customViewCellHeigth)
        }
        
        func playVideo(at indexPath: IndexPath){
            let model = viewModelDataSource.videosArray[indexPath.row]
            let urlVideo = model.video_files[3].link
            player = AVPlayer(url: URL(string: urlVideo)!)
            playerViewController.player = player
            playerViewController.allowsPictureInPicturePlayback = true
            self.present(playerViewController, animated: true, completion: nil)
        }
    }

