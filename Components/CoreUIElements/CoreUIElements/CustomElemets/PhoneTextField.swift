//
//  PhoneTextField.swift
//  CoreUIElements
//
//  Created by Yo'ldoshev Asadbek on 15/08/2025.
//

import SwiftUI
import UIKit

/// SwiftUI-обёртка над UITextField с маской +998 (XX) XXX-XX-XX
public struct PhoneTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String

    public init(text: Binding<String>, placeholder: String = "+998 (__) ___-__-__") {
        self._text = text
        self.placeholder = placeholder
    }

    public func makeUIView(context: Context) -> UITextField {
        let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.placeholder = placeholder
        tf.addTarget(context.coordinator, action: #selector(Coordinator.onEditingChanged(_:)), for: .editingChanged)
        tf.delegate = context.coordinator
        tf.text = formatUzbek(text) // начальное форматирование
        return tf
    }

    public func updateUIView(_ uiView: UITextField, context: Context) {
        // если binding изменился извне — синхронизируем поле
        let formatted = formatUzbek(text)
        if uiView.text != formatted {
            uiView.text = formatted
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    public final class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String

        init(text: Binding<String>) { self._text = text }

        @objc func onEditingChanged(_ sender: UITextField) {
            let current = sender.text ?? ""
            let newFormatted = formatUzbek(current)
            if sender.text != newFormatted {
                // простая стратегия: ставим курсор в конец
                sender.text = newFormatted
                moveCursorToEnd(sender)
            }
            text = newFormatted
        }

        public func textField(_ textField: UITextField,
                              shouldChangeCharactersIn range: NSRange,
                              replacementString string: String) -> Bool {
            // Разрешаем только цифры и Backspace
            if string.isEmpty { return true } // backspace
            if string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil {
                return false
            }
            // Промежуточная строка
            let current = textField.text ?? ""
            if let swiftRange = Range(range, in: current) {
                let candidate = current.replacingCharacters(in: swiftRange, with: string)
                // Применим формат к кандидату и проверим лимит
                let digits = onlyDigits(candidate)
                // первые 3 — код страны 998, дальше максимум 9 локальных
                let localCount = max(0, digits.count - 3)
                if localCount > 9 { return false }
            }
            return true
        }

        private func moveCursorToEnd(_ tf: UITextField) {
            if let end = tf.endOfDocument as UITextPosition? {
                tf.selectedTextRange = tf.textRange(from: end, to: end)
            }
        }
    }
}

public func onlyDigits(_ s: String) -> String {
    s.filter(\.isNumber)
}

/// Формат: +998 (XX) XXX-XX-XX
private func formatUzbek(_ raw: String) -> String {
    // 1) оставляем только цифры
    var digits = onlyDigits(raw)

    // 2) обеспечиваем префикс 998
    if digits.hasPrefix("998") == false {
        if digits.hasPrefix("8") {
            // Иногда пользователь вводит «8...» — нормализуем к «998...»
            digits = "998" + digits.dropFirst(1)
        } else if digits.count <= 9 {
            // если ввели только локальные — тоже добавим 998
            digits = "998" + digits
        }
    }

    // 3) ограничиваем длину: 3 (998) + 9 локальных = 12
    if digits.count > 12 { digits = String(digits.prefix(12)) }

    // 4) раскладываем
    let afterCode = digits.dropFirst(min(3, digits.count)) // убираем 998 если есть
    let a = afterCode.prefix(2)                                   // (XX)
    let b = afterCode.dropFirst(min(2, afterCode.count)).prefix(3) // XXX
    let c = afterCode.dropFirst(min(5, afterCode.count)).prefix(2) // XX
    let d = afterCode.dropFirst(min(7, afterCode.count)).prefix(2) // XX

    var out = "+998"
    if !a.isEmpty { out += " (\(a))" }
    if !b.isEmpty { out += " \(b)" }
    if !c.isEmpty { out += "-\(c)" }
    if !d.isEmpty { out += "-\(d)" }
    return out
}
