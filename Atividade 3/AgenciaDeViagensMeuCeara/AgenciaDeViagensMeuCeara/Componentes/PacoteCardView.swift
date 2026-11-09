import SwiftUI

struct PacoteCardView: View {

    let pacote: PacoteViagem
    let estaFavorito: Bool
    let acaoFavorito: () -> Void

    var body: some View {
        HStack(spacing: 14) {

            Image(pacote.imagemNome)
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 110)
                .clipped()
                .clipShape(
                    RoundedRectangle(cornerRadius: 14)
                )

            VStack(alignment: .leading, spacing: 7) {

                Text(pacote.titulo)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)

                Label(
                    pacote.local,
                    systemImage: "location.fill"
                )
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)

                Label(
                    "\(pacote.diarias) diárias",
                    systemImage: "moon.stars.fill"
                )
                .font(.caption)
                .foregroundStyle(.secondary)

                Text(pacote.precoFormatado)
                    .font(.headline)
                    .foregroundStyle(.orange)
            }

            Spacer()

            VStack {
                Button {
                    acaoFavorito()
                } label: {
                    Image(
                        systemName: estaFavorito
                            ? "heart.fill"
                            : "heart"
                    )
                    .font(.title3)
                    .foregroundStyle(
                        estaFavorito ? .red : .secondary
                    )
                }
                .buttonStyle(.plain)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 6)
        }
        .padding()
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
        .shadow(
            color: .black.opacity(0.08),
            radius: 6,
            x: 0,
            y: 3
        )
    }
}
