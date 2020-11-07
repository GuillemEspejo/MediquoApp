//
//  RootSplitViewController.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 05/11/2020.
//

import Foundation
import UIKit

// Extension of UISplitViewController customized to the app needs. In this case, it always shows the main VC.
class RootSplitViewController: UISplitViewController {
    override func viewDidLoad() {
        self.delegate = self
        self.preferredDisplayMode = UISplitViewController.DisplayMode.oneBesideSecondary
        self.presentsWithGesture = false
    }
}

extension RootSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary
    }
}

