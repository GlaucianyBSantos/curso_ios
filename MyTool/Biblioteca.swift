class Biblioteca {

    private var livros: [Livro] = []

    func cadastrarLivro(_ livro: Livro) {

        if livros.contains(where: { $0.id == livro.id }) {
            print("Erro: ID já cadastrado.")
            return
        }

        livros.append(livro)
        print("Livro cadastrado com sucesso!")
    }

    func listarLivros() {

        if livros.isEmpty {
            print("Nenhum livro cadastrado.")
            return
        }

        livros.forEach {
            $0.exibirDetalhes()
        }
    }

    func buscarPorId(_ id: Int) -> Livro? {
        livros.first { $0.id == id }
    }

    func buscarPorTitulo(_ trecho: String) {

        let encontrados = livros.filter {
            $0.titulo.lowercased()
                .contains(trecho.lowercased())
        }

        if encontrados.isEmpty {
            print("Nenhum livro encontrado.")
            return
        }

        encontrados.forEach {
            $0.exibirDetalhes()
        }
    }

    func removerLivro(id: Int) {

        guard let indice = livros.firstIndex(where: {
            $0.id == id
        }) else {
            print("Livro não encontrado.")
            return
        }

        livros.remove(at: indice)
        print("Livro removido com sucesso.")
    }

    func atualizarLivro(
        id: Int,
        novoTitulo: String,
        novoAutor: String,
        novoAno: Int
    ) {

        guard let livro = buscarPorId(id) else {
            print("Livro não encontrado.")
            return
        }

        livro.atualizarTitulo(novoTitulo)
        livro.atualizarAutor(novoAutor)
        livro.atualizarAno(novoAno)

        print("Livro atualizado com sucesso!")
    }
}

