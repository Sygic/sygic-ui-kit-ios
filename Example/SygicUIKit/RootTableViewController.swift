//// RootTableViewController.swift
//
// Copyright (c) 2019 Sygic a.s.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit


class RootTableViewController: UITableViewController {
    
    let rowsData = [
        "Action Buttons",
        "Pins",
        "Compass",
        "Bottom Sheet",
        "Poi Detail Bottom Sheet",
        "Skins",
        "DetailCell Table",
        "Infobar",
        "Progress view",
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
            navigationController?.pushViewController(DetailCellTableTestViewController(), animated: true)
        case 7:
            navigationController?.pushViewController(InfobarTestViewController(), animated: true)
        case 8:
            navigationController?.pushViewController(GradientProgressExampleController(), animated: true)
        case 9:
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
