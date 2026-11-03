import Foundation

let biblioteca = Biblioteca()

var executando = true

while executando {

    print("""
    
    ===== BIBLIOTECA =====

    1 - Cadastrar Livro
    2 - Listar Livros
    3 - Buscar por ID
    4 - Buscar por Título
    5 - Atualizar Livro
    6 - Remover Livro
    7 - Emprestar Livro
    8 - Devolver Livro
    0 - Sair

    Escolha:
    """, terminator: " ")

    guard let opcaoTexto = readLine(),
          let opcao = Int(opcaoTexto) else {
        print("Opção inválida.")
        continue
    }

    switch opcao {

    case 1:

        print("ID:")
        let id = Int(readLine() ?? "") ?? 0

        print("Título:")
        let titulo = readLine() ?? ""

        print("Autor:")
        let autor = readLine() ?? ""

        print("Ano:")
        let ano = Int(readLine() ?? "") ?? 0

        let livro = Livro(
            id: id,
            titulo: titulo,
            autor: autor,
            anoPublicacao: ano
        )

        biblioteca.cadastrarLivro(livro)

    case 2:

        biblioteca.listarLivros()

    case 3:

        print("Informe o ID:")
        let id = Int(readLine() ?? "") ?? 0

        if let livro = biblioteca.buscarPorId(id) {
            livro.exibirDetalhes()
        } else {
            print("Livro não encontrado.")
        }

    case 4:

        print("Digite o título:")
        let titulo = readLine() ?? ""

        biblioteca.buscarPorTitulo(titulo)

    case 5:

        print("ID do livro:")
        let id = Int(readLine() ?? "") ?? 0

        print("Novo título:")
        let titulo = readLine() ?? ""

        print("Novo autor:")
        let autor = readLine() ?? ""

        print("Novo ano:")
        let ano = Int(readLine() ?? "") ?? 0

        biblioteca.atualizarLivro(
            id: id,
            novoTitulo: titulo,
            novoAutor: autor,
            novoAno: ano
        )

    case 6:

        print("ID do livro:")
        let id = Int(readLine() ?? "") ?? 0

        biblioteca.removerLivro(id: id)

    case 7:

        print("ID do livro:")
        let id = Int(readLine() ?? "") ?? 0

        if let livro = biblioteca.buscarPorId(id) {
            livro.emprestar()
            print("Livro emprestado.")
        }

    case 8:

        print("ID do livro:")
        let id = Int(readLine() ?? "") ?? 0

        if let livro = biblioteca.buscarPorId(id) {
            livro.devolver()
            print("Livro devolvido.")
        }

    case 0:

        executando = false
        print("Encerrando sistema...")

    default:

        print("Opção inválida.")
    }
}
