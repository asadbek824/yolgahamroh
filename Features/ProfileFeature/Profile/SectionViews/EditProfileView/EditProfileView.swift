//
//  EditProfileView.swift
//  Profile
//
//  Created by Yo'ldoshev Asadbek on 14/08/2025.
//

import SwiftUI
import UIKit
import CoreModels
import CoreUIElements
import CoreExtentions

struct EditProfileView: View {
    @StateObject private var vm: EditProfileViewModel
    @Environment(\.dismiss) private var dismiss

    init(viewModel: EditProfileViewModel) {
        _vm = StateObject(wrappedValue: viewModel)
    }

    init() {
        let user = UserRepository.shared.currentUser ?? UserModel(name: "", email: "", telephoneNumber: "")
        let vm = EditProfileViewModel(
            user: user,
            updateUser: UpdateUserUseCase(repo: UserRepository.shared),
            onSuccess: { }
        )
        _vm = StateObject(wrappedValue: vm)
    }

    var body: some View {
        ZStack {
            BackgroundView()

            List {
                Section(vm.sectionTitle) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(vm.nameLabel)
                            .font(.footnote)
                            .foregroundStyle(.secondary)

                        TextField(vm.nameLabel, text: Binding(
                            get: { vm.state.name },
                            set: { vm.updateName($0) }
                        ))
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled(true)

                        if let error = vm.state.nameError {
                            Text(error)
                                .font(.footnote)
                                .foregroundStyle(.red)
                        }
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text(vm.emailLabel)
                            .font(.footnote)
                            .foregroundStyle(.secondary)

                        TextField("name@example.com", text: Binding(
                            get: { vm.state.email },
                            set: { vm.updateEmail($0) }
                        ))
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)

                        if let error = vm.state.emailError {
                            Text(error)
                                .font(.footnote)
                                .foregroundStyle(.red)
                        }
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text(vm.phoneLabel)
                            .font(.footnote)
                            .foregroundStyle(.secondary)

                        PhoneTextField(
                            text: Binding(
                                get: { vm.state.phone },
                                set: { vm.updatePhone($0) }
                            ),
                            placeholder: "+998 (__) ___-__-__"
                        )

                        if let error = vm.state.phoneError {
                            Text(error)
                                .font(.footnote)
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
        }
        .safeAreaInset(edge: .bottom) {
            CustomGlassButton(
                title: vm.saveTitle,
                icon: "checkmark.circle.fill",
                cornerRadius: 16,
                foregroundColor: .primary
            ) {
                vm.save()
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 12)
            .disabled(!vm.canSave)
            .opacity(vm.canSave ? 1 : 0.6)
        }
        .dismissKeyboardOnTapGesture()
        .navigationTitle(vm.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .baseAlert(
            EditProfileStrings().discardTitle,
            isPresented: Binding(
                get: { vm.state.showDiscardAlert },
                set: { vm.setShowDiscardAlert($0) }
            ),
            style: .warning,
            message: EditProfileStrings().discardMessage,
            primary: .init(EditProfileStrings().cancel, kind: .destructive) {
                vm.confirmDiscard()
                dismiss()
            },
            secondary: nil
        )
    }
}
