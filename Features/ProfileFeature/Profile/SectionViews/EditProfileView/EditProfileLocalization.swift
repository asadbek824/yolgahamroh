//
//  EditProfileLocalization.swift
//  Profile
//
//  Created by Yo'ldoshev Asadbek on 15/08/2025.
//

import DesignSystem

protocol EditProfileLocalization {
    var title: String { get }
    var sectionPersonal: String { get }
    var name: String { get }
    var email: String { get }
    var phone: String { get }
    var save: String { get }
    var cancel: String { get }
    var invalidEmail: String { get }
    var invalidPhone: String { get }
    var emptyName: String { get }
    var discardTitle: String { get }
    var discardMessage: String { get }
    var discardKeepEditing: String { get }
}

struct EditProfileStrings: EditProfileLocalization {
    var title: String { "Редактировать профиль" }
    var sectionPersonal: String { "Личные данные" }
    var name: String { "Имя" }
    var email: String { "Email" }
    var phone: String { "Телефон" }
    var save: String { "Сохранить" }
    var cancel: String { "Отмена" }
    var invalidEmail: String { "Некорректный email" }
    var invalidPhone: String { "Некорректный номер" }
    var emptyName: String { "Имя не может быть пустым" }
    var discardTitle: String { "Отменить изменения?" }
    var discardMessage: String { "Несохранённые изменения будут потеряны." }
    var discardKeepEditing: String { "Продолжить" }
}
