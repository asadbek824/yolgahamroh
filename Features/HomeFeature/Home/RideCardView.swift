//
//  RideCardView.swift
//  Home
//
//  Created by Yo'ldoshev Asadbek on 04/08/2025.
//

import SwiftUI

struct RideCardView: View {
    let from: String
    let to: String
    let time: String
    let price: String
    let avatarImage: UIImage?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                avatarView

                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 4) {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.blue)
                        Text("\(from) → \(to)")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.primary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }

                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .foregroundColor(.gray)
                        Text(time)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    HStack(spacing: 4) {
                        Image(systemName: "creditcard")
                            .foregroundColor(.green)
                        Text(price)
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.green)
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray.opacity(0.4))
            }

            Button(action: {
                print("Забронировать")
            }) {
                Text("Забронировать")
                    .font(.callout.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(
                    color: Color.black.opacity(0.05),
                    radius: 6, x: 0, y: 3
                )
        )
    }

    private var avatarView: some View {
        Group {
            if let image = avatarImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray.opacity(0.6))
            }
        }
        .frame(width: 56, height: 56)
        .background(Color.gray.opacity(0.1))
        .clipShape(Circle())
    }
}

#Preview {
    RideCardView(
        from: "Ташкент",
        to: "Самарканд",
        time: "Сегодня, 15:00",
        price: "150 000 UZS",
        avatarImage: UIImage(systemName: "person.circle")
    )
}
