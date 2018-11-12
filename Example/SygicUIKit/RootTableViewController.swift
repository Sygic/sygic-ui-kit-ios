import UIKit

class RootTableViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Action buttons"
//        case 1:
//            cell.textLabel?.text = "Compass"
        case 1:
            cell.textLabel?.text = "Bottom sheet"
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(ButtonTestViewController(), animated: true)
//        case 1:
//            compass demonstration
        case 1:
            navigationController?.pushViewController(BottomSheetTestViewController(), animated: true)
        default:
            break
        }
    }
}
