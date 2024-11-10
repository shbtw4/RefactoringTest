//
//  ChangePasswordViewCommand.swift
//  Refactoring
//
//  Created by Nikolay Shishkin on 08/11/2024.
//

import Foundation

protocol ChangePasswordViewCommand: AnyObject {
    func hideActivityIndicator()
    func showActivityIndicator()
    func dismissModal()
    func showAlert(_ message: String, _ action: @escaping () -> Void)
    func showBlurView()
    func hideBlurView()
    func setCancelButtonEnabled(_ enabled: Bool)
    func updateInputFocus(_ inputFocus: InputFocus)
    func clearAllPasswordFields()
    func clearNewPasswordFields()
}

enum InputFocus {
    case noKeyboard
    case oldPassword
    case newPassword
    case confirmPassword
}
