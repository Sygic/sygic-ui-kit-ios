import UIKit

class RootTableViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Action buttons"
        case 1:
            cell.textLabel?.text = "Bottom sheet"
        case 2:
            cell.textLabel?.text = "Pin"
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(ButtonTestViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(BottomSheetTestViewController(), animated: true)
        case 2:
            navigationController?.pushViewController(PinTestViewController(), animated: true)
        default:
            break
        }
    }
}
