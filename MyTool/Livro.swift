import Foundation

class Livro: Documento {

    let id: Int
    private(set) var titulo: String
    private(set) var autor: String
    private(set) var anoPublicacao: Int
    private(set) var isEmprestado: Bool

    init(
        id: Int,
        titulo: String,
        autor: String,
        anoPublicacao: Int
    ) {
        self.id = id
        self.titulo = titulo
        self.autor = autor
        self.anoPublicacao = anoPublicacao
        self.isEmprestado = false
    }

    func atualizarTitulo(_ novoTitulo: String) {
        titulo = novoTitulo
    }

    func atualizarAutor(_ novoAutor: String) {
        autor = novoAutor
    }

    func atualizarAno(_ novoAno: Int) {
        anoPublicacao = novoAno
    }

    func emprestar() {
        if !isEmprestado {
            isEmprestado = true
        }
    }

    func devolver() {
        if isEmprestado {
            isEmprestado = false
        }
    }

    func exibirDetalhes() {
        print("""
        --------------------------
        ID: \(id)
        Título: \(titulo)
        Autor: \(autor)
        Ano: \(anoPublicacao)
        Emprestado: \(isEmprestado ? "Sim" : "Não")
        --------------------------
        """)
    }
}
