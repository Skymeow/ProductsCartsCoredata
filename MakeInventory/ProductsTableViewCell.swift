//
//  ProductsTableViewCell.swift
//  MakeInventory
//
//  Created by Sky Xu on 11/19/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit

protocol ProductsDelegate: class {
    func passIndex(indexPath: IndexPath)
}

class ProductsTableViewCell: UITableViewCell {
    weak var delegate: ProductsDelegate?
    var indexPath: IndexPath?
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productQuantity: UILabel!
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        delegate?.passIndex(indexPath: self.indexPath!)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
