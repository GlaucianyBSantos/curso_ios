class LivroDigital: Livro {

    private(set) var tamanhoEmMB: Double

    init(
        id: Int,
        titulo: String,
        autor: String,
        anoPublicacao: Int,
        tamanhoEmMB: Double
    ) {
        self.tamanhoEmMB = tamanhoEmMB

        super.init(
            id: id,
            titulo: titulo,
            autor: autor,
            anoPublicacao: anoPublicacao
        )
    }

    override func exibirDetalhes() {
        super.exibirDetalhes()
        print("Tamanho do arquivo: \(tamanhoEmMB) MB")
    }
}
