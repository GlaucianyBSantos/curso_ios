import SwiftUI

struct DetalhesPacoteView: View {

    let pacote: PacoteViagem

    @Binding var favoritos: Set<UUID>

    @Binding var reservas: [PacoteViagem]

    @Environment(\.dismiss) private var dismiss

    @State private var mostrarConfirmacao = false
    
    private var estaFavorito: Bool {
        favoritos.contains(pacote.id)
    }

    private var simboloMarcaDagua: String {

        switch pacote.imagemNome {

        case "jericoacoara":
            return "ferry.fill"

        case "canoaQuebrada":
            return "moon.stars.fill"

        case "fortaleza":
            return "sun.max.fill"

        case "guaramiranga":
            return "leaf.fill"

        case "ibiapaba":
            return "tree.fill"

        case "cumbuco":
            return "wind"

        case "morroBranco":
            return "triangle.fill"

        case "cariri":
            return "music.note"

        default:
            return "sun.max.fill"
        }
    }
    var body: some View {

        VStack(spacing: 0) {

            ZStack(alignment: .bottomTrailing) {

                ScrollView {

                    VStack(alignment: .leading, spacing: 14) {

                        imagemDestaque

                        VStack(alignment: .leading, spacing: 12) {

                            tituloELocal

                            Divider()

                            informacoesViagem

                            Divider()

                            informacoesHospedagem
                        }
                        .padding()
                    }
                }

                Image(systemName: simboloMarcaDagua)                    .font(.system(size: 100))
                    .foregroundStyle(.orange.opacity(0.10))
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .trailing
                    )
                    .padding(.trailing, 20)
            }

            VStack(spacing: 8) {

                botaoFavoritoFixo

                botaoReservaFixo
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .background(.regularMaterial)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Detalhes do Pacote")
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            "Reserva Confirmada",
            isPresented: $mostrarConfirmacao
        ) {

            Button("OK") {

                dismiss()
            }

        } message: {

            Text("Sua reserva para \(pacote.titulo) foi registrada com sucesso.")
        }
    }

    // MARK: - Imagem

    private var imagemDestaque: some View {

        Image(pacote.imagemNome)
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: 160)
            .clipped()
    }

    // MARK: - Título e Localização

    private var tituloELocal: some View {

        VStack(alignment: .leading, spacing: 10) {

            Text(pacote.titulo)
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)

            Label {

                Text(pacote.local)
                    .fixedSize(horizontal: false, vertical: true)

            } icon: {

                Image(systemName: "location.fill")
            }
            .font(.headline)
            .foregroundStyle(.secondary)
        }
    }

    // MARK: - Informações da viagem

    private var informacoesViagem: some View {

        VStack(alignment: .leading, spacing: 16) {

            Text("Informações da viagem")
                .font(.title2)
                .bold()

            Label(
                "Partida: \(pacote.dataPartida)",
                systemImage: "airplane.departure"
            )

            Label(
                "\(pacote.diarias) diárias",
                systemImage: "calendar"
            )

            Label(
                "Retorno: \(pacote.dataChegada)",
                systemImage: "airplane.arrival"
            )
        }
    }

    // MARK: - Hospedagem

    private var informacoesHospedagem: some View {

        VStack(alignment: .leading, spacing: 12) {

            Text("Hospedagem")
                .font(.title2)
                .bold()

            Label {

                Text(pacote.informacoesHotel)
                    .fixedSize(horizontal: false, vertical: true)

            } icon: {

                Image(systemName: "building.2.fill")
                    .foregroundStyle(.orange)
            }
        }
    }

    // MARK: - Favoritos

    private var botaoFavoritoFixo: some View {

        Button {

            alterarFavorito()

        } label: {

            HStack(spacing: 8) {

                Image(
                    systemName: estaFavorito
                    ? "heart.slash.fill"
                    : "heart.fill"
                )

                Text(
                    estaFavorito
                    ? "Remover dos favoritos"
                    : "Adicionar aos favoritos"
                )
                .bold()
            }
            .foregroundStyle(
                estaFavorito
                ? Color.red
                : Color.white
            )
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(
                estaFavorito
                ? Color.red.opacity(0.12)
                : Color.orange
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
        }
    }

    // MARK: - Reserva

    private var botaoReservaFixo: some View {

        Button {

            if !reservas.contains(where: { $0.id == pacote.id }) {

                reservas.append(pacote)
            }

            mostrarConfirmacao = true

        } label: {

            VStack(spacing: 2) {

                Text("Reservar agora")
                    .font(.headline)

                Text(pacote.precoFormatado)
                    .font(.title3)
                    .bold()
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .background(.blue)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
        }
    }

    // MARK: - Funções

    private func alterarFavorito() {

        if estaFavorito {

            favoritos.remove(pacote.id)

        } else {

            favoritos.insert(pacote.id)
        }
    }
}
