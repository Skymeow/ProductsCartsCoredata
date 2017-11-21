//
//  ProductsTableViewCell.swift
//  MakeInventory
//
//  Created by Sky Xu on 11/19/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit

protocol ProductsDelegate: class {
    func passProduct(_ product: Inventory)
}

class ProductsTableViewCell: UITableViewCell {
    weak var delegate: ProductsDelegate?
    var indexPath: IndexPath?
    var product: Inventory!
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productQuantity: UILabel!
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        delegate?.passProduct(self.product)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
