//
//  SearchResultCell.swift
//  StoreSearch
//
//  Created by Maryna Bolotska on 09/11/23.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    
    
    override func awakeFromNib() {
      super.awakeFromNib()
      // New code below
      let selectedView = UIView(frame: CGRect.zero)
      selectedView.backgroundColor = UIColor(named: "SearchBar")?.withAlphaComponent(0.5)
        selectedBackgroundView = selectedView
      }
}
