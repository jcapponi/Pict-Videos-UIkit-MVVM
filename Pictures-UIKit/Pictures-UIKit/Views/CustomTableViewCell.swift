//
//  CustomTableViewCell.swift
//  Pictures-UIKit
//
//  Created by Juan Capponi on 9/21/20.
//  Copyright © 2020 Juan Capponi. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var picture: UIImageView!
    
    static let cellIdentifier = "CustomTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() ->    UINib {
        return UINib(nibName: "CustomTableViewCell", bundle: nil)
    }
    
    public func configue(with viewModel: CellViewModelPictures) {
        name.text = viewModel.photographerName       
        viewModel.loadPicture(url: viewModel.urlSmall) { [weak self] (img) in
            DispatchQueue.main.async {
                self?.picture.image = img
                self?.picture.contentMode = .scaleAspectFill
            }
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
