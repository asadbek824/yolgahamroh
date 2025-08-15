//
//  EditProfileViewModel.swift
//  Profile
//
//  Created by Yo'ldoshev Asadbek on 15/08/2025.
//

import SwiftUI
import CoreModels
import CoreUIElements

@MainActor
final class EditProfileViewModel: ObservableObject {

    struct State: Equatable {
        var name: String
        var email: String
        var phone: String

        var isSaving = false
        var showDiscardAlert = false

        var emailError: String? = nil
        var phoneError: String? = nil
        var nameError:  String? = nil

        var original: UserModel
    }

    @Published private(set) var state: State

    private let strings: EditProfileLocalization
    private let updateUser: UpdateUserUseCaseProtocol
    private let onSuccess: () -> Void

    // — хранить workItem, чтобы не плодить много async-валидаторов
    private var validateWorkItem: DispatchWorkItem?

    init(
        user: UserModel,
        strings: EditProfileLocalization = EditProfileStrings(),
        updateUser: UpdateUserUseCaseProtocol,
        onSuccess: @escaping () -> Void
    ) {
        self.strings = strings
        self.updateUser = updateUser
        self.onSuccess = onSuccess
        self.state = State(
            name: user.name,
            email: user.email,
            phone: user.telephoneNumber,
            original: user
        )
    }

    // MARK: - Derived (только чтение, никаких мутаций!)
    var title: String { strings.title }
    var sectionTitle: String { strings.sectionPersonal }
    var saveTitle: String { strings.save }
    var cancelTitle: String { strings.cancel }
    var nameLabel: String { strings.name }
    var emailLabel: String { strings.email }
    var phoneLabel: String { strings.phone }

    var isDirty: Bool {
        state.name  != state.original.name ||
        state.email != state.original.email ||
        state.phone != state.original.telephoneNumber
    }

    var isValid: Bool {
        isNameValid(state.name) && isEmailValid(state.email) && isPhoneValid(state.phone)
    }

    var canSave: Bool { isDirty && isValid && !state.isSaving }

    // MARK: - Intent
    func updateName(_ text: String) {
        state.name = text.trimmingCharacters(in: .whitespaces)
        scheduleErrorsRecalc()
    }

    func updateEmail(_ text: String) {
        state.email = text.trimmingCharacters(in: .whitespaces)
        scheduleErrorsRecalc()
    }

    func updatePhone(_ text: String) {
        state.phone = text.trimmingCharacters(in: .whitespaces)
        scheduleErrorsRecalc()
    }

    func save() {
        guard canSave else { return }
        state.isSaving = true
        let newUser = UserModel(name: state.name, email: state.email, telephoneNumber: state.phone)
        updateUser.execute(newUser)
        state.isSaving = false
        onSuccess()
    }

    func requestCancel() {
        if isDirty { state.showDiscardAlert = true } else { onSuccess() }
    }

    func setShowDiscardAlert(_ value: Bool) { state.showDiscardAlert = value }
    func confirmDiscard() { state.showDiscardAlert = false; onSuccess() }
    func keepEditing()    { state.showDiscardAlert = false }

    // MARK: - PURE validation (без мутаций)
    private func isNameValid(_ s: String) -> Bool {
        !s.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func isEmailValid(_ s: String) -> Bool {
        guard !s.isEmpty else { return true }
        let pattern = #"^\S+@\S+\.\S+$"#
        return s.range(of: pattern, options: .regularExpression) != nil
    }

    private func isPhoneValid(_ s: String) -> Bool {
        onlyDigits(s).count == 12
    }

    // MARK: - Error texts (мутации — только вне рендера)
    private func scheduleErrorsRecalc() {
        validateWorkItem?.cancel()
        let item = DispatchWorkItem { [weak self] in self?.recalcErrors() }
        validateWorkItem = item
        DispatchQueue.main.async(execute: item) // откладываем на следующий тик
    }

    private func recalcErrors() {
        state.nameError  = isNameValid(state.name)  ? nil : strings.emptyName
        state.emailError = isEmailValid(state.email) ? nil : strings.invalidEmail
        state.phoneError = isPhoneValid(state.phone) ? nil : strings.invalidPhone
    }
}
