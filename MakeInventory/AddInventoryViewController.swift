import UIKit
import CoreData
class AddInventoryViewController: UIViewController {
    let coreDataStack = CoreDataStack.instance
    
    @IBOutlet weak var inventoryNameField: UITextField!
    @IBOutlet weak var inventoryQuantityField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func savePressed(_ sender: Any) {
        guard let name = inventoryNameField.text,
            let quantity = Int64(inventoryQuantityField.text!) else {return}
        let newInv = Inventory(context: coreDataStack.privateContext)
        print(newInv.managedObjectContext?.concurrencyType)
        newInv.name = name
        newInv.quantity = quantity
        coreDataStack.saveTo(context: coreDataStack.privateContext)
        
        self.navigationController?.popViewController(animated: true)
    }

    
}
