import SwiftUI

struct ContentView: View {

    enum TipoOrdenacao: String, CaseIterable {
        case menorPreco = "Menor preço"
        case maiorPreco = "Maior preço"
    }

    @Binding var favoritos: Set<UUID>

    @Binding var reservas: [PacoteViagem]

    @State private var textoBusca = ""

    @State private var ordenacao: TipoOrdenacao = .menorPreco

    var body: some View {

        NavigationStack {

            ZStack {

                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView {

                    VStack(spacing: 24) {

                        cabecalho

                        campoBusca

                        seletorOrdenacao

                        listaPacotes
                    }
                    
                }
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    botaoFavoritos
                }
            }
        }
    }

    // MARK: - Cabeçalho

    private var cabecalho: some View {

        VStack(spacing: 10) {

            Image(systemName: "sun.max.fill")
                .font(.system(size: 60))
                .foregroundStyle(.orange)

            Text("Agência de Viagens")
                .font(.headline)
                .foregroundStyle(.secondary)

            Text("Meu Ceará")
                .font(.largeTitle)
                .bold()

            Text("Viva as cores e os caminhos do Ceará.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        
    }
    

    // MARK: - Busca

    private var campoBusca: some View {

        HStack {

            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField(
                "Buscar destino...",
                text: $textoBusca
            )

            if !textoBusca.isEmpty {

                Button {

                    textoBusca = ""

                } label: {

                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
    }

    // MARK: - Ordenação

    private var seletorOrdenacao: some View {

        Picker(
            "Ordenar",
            selection: $ordenacao
        ) {

            ForEach(
                TipoOrdenacao.allCases,
                id: \.self
            ) { tipo in

                Text(tipo.rawValue)
                    .tag(tipo)
            }
        }
        .pickerStyle(.segmented)
    }

    // MARK: - Pacotes filtrados

    private var pacotesFiltrados: [PacoteViagem] {

        let busca = textoBusca
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let filtrados: [PacoteViagem]

        if busca.isEmpty {

            filtrados = pacotesViagem

        } else {

            filtrados = pacotesViagem.filter { pacote in

                pacote.titulo.localizedCaseInsensitiveContains(busca)
                ||
                pacote.local.localizedCaseInsensitiveContains(busca)
                ||
                pacote.informacoesHotel.localizedCaseInsensitiveContains(busca)
            }
        }

        switch ordenacao {

        case .menorPreco:

            return filtrados.sorted {
                $0.preco < $1.preco
            }

        case .maiorPreco:

            return filtrados.sorted {
                $0.preco > $1.preco
            }
        }
    }

    // MARK: - Lista de pacotes

    private var listaPacotes: some View {

        LazyVStack(spacing: 18) {

            if pacotesFiltrados.isEmpty {

                VStack(spacing: 16) {

                    Image(systemName: "magnifyingglass.circle")
                        .font(.system(size: 60))
                        .foregroundStyle(.orange)

                    Text("Nenhum destino encontrado")
                        .font(.title3)
                        .bold()

                    Text("Tente pesquisar outro destino.")
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 40)

            } else {

                ForEach(pacotesFiltrados) { pacote in

                    NavigationLink {

                        DetalhesPacoteView(
                            pacote: pacote,
                            favoritos: $favoritos,
                            reservas: $reservas
                        )

                    } label: {

                        PacoteCardView(
                            pacote: pacote,
                            estaFavorito: favoritos.contains(pacote.id),
                            acaoFavorito: {
                                alterarFavorito(pacote)
                            }
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    // MARK: - Favoritos

    private var botaoFavoritos: some View {

        HStack(spacing: 5) {

            Image(
                systemName: favoritos.isEmpty
                ? "heart"
                : "heart.fill"
            )

            Text("\(favoritos.count)")
                .font(.caption)
                .bold()
        }
        .foregroundStyle(
            favoritos.isEmpty
            ? Color.secondary
            : Color.red
        )
    }

    // MARK: - Funções

    private func alterarFavorito(_ pacote: PacoteViagem) {

        if favoritos.contains(pacote.id) {

            favoritos.remove(pacote.id)

        } else {

            favoritos.insert(pacote.id)
        }
    }
}

#Preview {

    ContentView(
        favoritos: .constant([]),
        reservas: .constant([])
    )
}
