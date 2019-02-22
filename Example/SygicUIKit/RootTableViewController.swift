import UIKit


class RootTableViewController: UITableViewController {
    
    let rowsData = [
        "Action Buttons",
        "Pins",
        "Compass",
        "Bottom Sheet",
        "Poi Detail Bottom Sheet",
        "Skins",
        "Zoom Controls"
    ]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = rowsData[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(ButtonTestViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(PinTestViewController(), animated: true)
        case 2:
            navigationController?.pushViewController(CompassTestViewController(), animated: true)
        case 3:
            navigationController?.pushViewController(BottomSheetTestViewController(), animated: true)
        case 4:
            navigationController?.pushViewController(PoiDetailTestViewController(), animated: true)
        case 5:
            navigationController?.pushViewController(SkinTestViewController(), animated: true)
        case 6:
            navigationController?.pushViewController(ZoomTestViewController(), animated: true)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "UI Kit"
        }
        return nil
    }
    
}
