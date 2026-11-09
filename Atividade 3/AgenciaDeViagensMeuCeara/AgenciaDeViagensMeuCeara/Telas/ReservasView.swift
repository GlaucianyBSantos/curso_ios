import SwiftUI

struct ReservasView: View {

    @Binding var reservas: [PacoteViagem]

    var body: some View {

        NavigationStack {

            Group {

                if reservas.isEmpty {

                    VStack(spacing: 20) {

                        Image(systemName: "ticket.fill")
                            .font(.system(size: 70))
                            .foregroundStyle(.blue)

                        Text("Nenhuma reserva realizada")
                            .font(.title2)
                            .bold()

                        Text("As reservas confirmadas aparecerão aqui.")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                    }
                    .padding()

                } else {

                    ScrollView {

                        LazyVStack(spacing: 18) {

                            ForEach(reservas) { pacote in

                                VStack(alignment: .leading, spacing: 10) {

                                    Image(pacote.imagemNome)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 180)
                                        .frame(maxWidth: .infinity)
                                        .clipped()
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 12)
                                        )

                                    Text(pacote.titulo)
                                        .font(.headline)

                                    Text(pacote.local)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)

                                    HStack {

                                        Image(systemName: "calendar")

                                        Text("\(pacote.diarias) diárias")
                                    }
                                    .font(.caption)

                                    Text(pacote.precoFormatado)
                                        .font(.title3)
                                        .bold()
                                        .foregroundStyle(.blue)

                                    Button {

                                        removerReserva(pacote)

                                    } label: {

                                        Label(
                                            "Cancelar Reserva",
                                            systemImage: "trash"
                                        )
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 10)
                                        .background(Color.red)
                                        .foregroundStyle(.white)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 10)
                                        )
                                    }
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 16)
                                )
                                .shadow(
                                    color: .black.opacity(0.08),
                                    radius: 5,
                                    x: 0,
                                    y: 2
                                )
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Minhas Reservas")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func removerReserva(_ pacote: PacoteViagem) {

        reservas.removeAll {
            $0.id == pacote.id
        }
    }
}

#Preview {

    ReservasView(
        reservas: .constant([])
    )
}
