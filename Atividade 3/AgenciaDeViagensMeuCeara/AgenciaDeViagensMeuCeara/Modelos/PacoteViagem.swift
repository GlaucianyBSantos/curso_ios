import Foundation

struct PacoteViagem: Identifiable {

    let id = UUID()
    let titulo: String
    let diarias: Int
    let local: String
    let dataPartida: String
    let dataChegada: String
    let informacoesHotel: String
    let imagemNome: String
    let preco: Double

    var precoFormatado: String {
        preco.formatted(
            .currency(code: "BRL")
                .locale(Locale(identifier: "pt_BR"))
        )
    }
}
