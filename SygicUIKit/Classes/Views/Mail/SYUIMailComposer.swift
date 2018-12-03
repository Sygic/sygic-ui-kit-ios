import Foundation
import UIKit
import MessageUI

public typealias SYUIMailCompletion = (_ result: MFMailComposeResult) -> ()

public class SYUIMailComposer: MFMailComposeViewController, MFMailComposeViewControllerDelegate {
    
    var completion: SYUIMailCompletion?
    
    public func present(from controller: UIViewController, recipient: String, subject: String, body: String, completion: @escaping SYUIMailCompletion) {
        if MFMailComposeViewController.canSendMail() {
            self.completion = completion
            mailComposeDelegate = self
            setToRecipients([recipient])
            setSubject(subject)
            setMessageBody(body, isHTML: false)
            controller.present(self, animated: true, completion: nil)
        }
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        completion?(result)
    }

}
