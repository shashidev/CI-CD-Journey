//
//  ViewController.swift
//  RetirementCalculator
//
//  Created by Shashi Ranjan on 20/11/24.
//

import UIKit
import AppCenterCrashes
import AppCenterAnalytics

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var monthlyInvestmentsTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var retirementAgeTextField: UITextField!
    @IBOutlet weak var interestRateTextField: UITextField!
    @IBOutlet weak var savingsTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let headerView = tableView.tableHeaderView {
            updateTableHeaderViewHeight(headerView)
        }

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
    }

    func updateTableHeaderViewHeight(_ header: UIView) {
        // Force the layout of the header view
        header.setNeedsLayout()
        header.layoutIfNeeded()

        // Update the frame to fit the content
        let height = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        header.frame.size.height = height

        // Assign back to the table view
        tableView.tableHeaderView = header
    }

    override func viewDidAppear(_ animated: Bool) {
        if Crashes.hasCrashedInLastSession {
            let alert = UIAlertController(title: "Oops", message: "Sorry about that, an error occured.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "It's cool", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

        Analytics.trackEvent("navigated_to_calculator")
    }

    @IBAction func calculateRetirementAmountButton(_ sender: UIButton) {
        // MSCrashes.generateTestCrash()

        let current_age : Int? = Int(ageTextField.text!)
        let planned_retirement_age : Int? = Int(retirementAgeTextField.text!)
        let monthly_investment : Float? = Float(monthlyInvestmentsTextField.text!)
        let current_savings : Float? = Float(savingsTextField.text!)
        let interest_rate : Float? = Float(interestRateTextField.text!)

        resultLabel.text = "If you save $\(monthly_investment!) every month for \(planned_retirement_age! - current_age!) years, and invest that money plus your current investment of $\(current_savings!) at a \(interest_rate!)% anual interest rate, you will have $X by the time you are \(planned_retirement_age!)"


        let properties = ["current_age": String(current_age!),
                          "planned_retirement_age": String(planned_retirement_age!)]

        Analytics.trackEvent("calculate_retirement_amount", withProperties: properties)
    }
    
}

