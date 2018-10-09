import UIKit

extension UITableView {
    
    func register(cellType: UITableViewCell.Type) {
        register(cellType, forCellReuseIdentifier: String(describing: cellType.self))
    }

    func dequeue<Row: UITableViewCell>(indexPath: IndexPath) -> Row {
        return dequeueReusableCell(withIdentifier: String(describing: Row.self), for: indexPath) as! Row
    }
}
