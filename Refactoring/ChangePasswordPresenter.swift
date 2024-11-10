//
//  ChangePasswordPresenter.swift
//  Refactoring
//
//  Created by Nikolay Shishkin on 08/11/2024.
//

import Foundation

class ChangePasswordPresenter {
    private unowned var view: ChangePasswordViewCommand
    private let viewModel: ChangePasswordLabels
    var securityToken: String
    private let passwordChanger: PasswordChanging
    
    init(view: ChangePasswordViewCommand, viewModel: ChangePasswordLabels, securityToken: String, passwordChanger: PasswordChanging) {
        self.view = view
        self.viewModel = viewModel
        self.securityToken = securityToken
        self.passwordChanger = passwordChanger
    }
    
    func cancel() {
        view.updateInputFocus(.noKeyboard)
        view.dismissModal()
    }
    
    func changePassword(_ passwordInputs: PasswordInputs) {
        guard validateInputs(passwordInputs) else { return }
        setUpWaitingAppearance()
        attemptToChangePassword(passwordInputs)
    }
    
    private func handleSuccess() {
        view.hideActivityIndicator()
        view.showAlert(viewModel.successMessage) { [weak self] in
            self?.view.dismissModal()
        }
    }
    
    private func handleFailure(_ message: String) {
        view.hideActivityIndicator()
        view.showAlert(message) { [weak self] in
            self?.startOver()
        }
    }
    
    private func attemptToChangePassword(_ passwordInputs: PasswordInputs) {
        passwordChanger.change(
            securityToken: securityToken,
            oldPassword: passwordInputs.oldPassword, newPassword: passwordInputs.newPassword,
            onSuccess: { [weak self] in
                self?.handleSuccess()
            },
            onFailure: { [weak self] message in
                self?.handleFailure(message)
            })
    }
    
    private func setUpWaitingAppearance() {
        view.updateInputFocus(.noKeyboard)
        view.setCancelButtonEnabled(false)
        view.showBlurView()
        view.showActivityIndicator()
    }
    
    private func resetNewPasswords() {
        view.clearNewPasswordFields()
        view.updateInputFocus(.newPassword)
    }
    
    private func validateInputs(_ passwordInputs: PasswordInputs) -> Bool {
        if passwordInputs.isOldPasswordEmpty {
            view.updateInputFocus(.oldPassword)
            return false
        }
        if passwordInputs.isNewPasswordEmpty {
            let message = viewModel.enterNewPasswordMessage
            view.showAlert(message) { [weak self] in
                self?.view.updateInputFocus(.newPassword)
            }
            return false
        }
        
        if passwordInputs.isNewPasswordTooShort {
            let message = viewModel.newPasswordTooShortMessage
            view.showAlert(message) { [weak self] in
                self?.resetNewPasswords()
            }
            return false
        }
        if passwordInputs.isConfirmPasswordMismatched {
            let message = viewModel.confirmationPasswordDoesNotMatchMessage
            view.showAlert(message) { [weak self] in
                self?.resetNewPasswords()
            }
            return false
        }
        return true
    }
    
    private func startOver() {
        view.clearAllPasswordFields()
        view.updateInputFocus(.oldPassword)
        view.setCancelButtonEnabled(true)
        view.hideBlurView()
    }
}
