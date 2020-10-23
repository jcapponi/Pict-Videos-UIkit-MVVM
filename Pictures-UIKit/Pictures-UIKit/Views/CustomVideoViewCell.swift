//
//  CustomVideoViewCell.swift
//  Pictures-UIKit
//
//  Created by Juan Capponi on 9/23/20.
//  Copyright © 2020 Juan Capponi. All rights reserved.
//

import UIKit

class CustomVideoViewCell: UITableViewCell {

    @IBOutlet var name: UILabel!
        @IBOutlet var picture: UIImageView!
        
        static let cellIdentifier = "CustomVideoViewCell"
        
        override func awakeFromNib() {
            super.awakeFromNib()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Configure the view for the selected state
        }
        
        static func nib() ->    UINib {
            return UINib(nibName: "CustomVideoViewCell", bundle: nil)
        }
        
        public func configueVideo(with viewModel: CellViewModelMovies) {
            name.text = viewModel.name
            viewModel.loadPicture(url: viewModel.imgageUrl) { [weak self] (img) in
                DispatchQueue.main.async {
                    self?.picture.image = img
                    self?.picture.contentMode = .scaleAspectFill
                }
            }
        }
}
