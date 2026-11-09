import SwiftUI

struct FavoritosView: View {

    @Binding var favoritos: Set<UUID>

    @Binding var reservas: [PacoteViagem]

    private var pacotesFavoritos: [PacoteViagem] {

        pacotesViagem.filter {
            favoritos.contains($0.id)
        }
    }

    var body: some View {

        NavigationStack {

            Group {

                if pacotesFavoritos.isEmpty {

                    VStack(spacing: 20) {

                        Image(systemName: "heart.fill")
                            .font(.system(size: 70))
                            .foregroundStyle(.red)

                        Text("Nenhum favorito ainda")
                            .font(.title2)
                            .bold()

                        Text(
                            "Adicione destinos aos favoritos na aba Explorar."
                        )
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                    }
                    .padding()

                } else {

                    ScrollView {

                        LazyVStack(spacing: 18) {

                            ForEach(pacotesFavoritos) { pacote in

                                NavigationLink {

                                    DetalhesPacoteView(
                                        pacote: pacote,
                                        favoritos: $favoritos,
                                        reservas: $reservas
                                    )

                                } label: {

                                    PacoteCardView(
                                        pacote: pacote,
                                        estaFavorito: true,
                                        acaoFavorito: {
                                            favoritos.remove(pacote.id)
                                        }
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Meus Destinos Favoritos")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {

    FavoritosView(
        favoritos: .constant([]),
        reservas: .constant([])
    )
}
