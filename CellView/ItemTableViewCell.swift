//
//  ItemTableViewCell.swift
//  GetUntukBella
//
//  Created by Putra on 09/11/21.
//

import UIKit
import SDWebImage
class ItemTableViewCell: UITableViewCell {

    static let identifier = "ItemTableViewCell"
    @IBOutlet weak var imgResto: UIImageView!
    @IBOutlet weak var restoLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(resto: Resto) {
        imgResto.sd_setImage(with: URL(string: "https://restaurant-api.dicoding.dev/images/medium/\(resto.pictureId!)"))
        restoLabel.text = resto.name
        locationLabel.text = resto.city
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
