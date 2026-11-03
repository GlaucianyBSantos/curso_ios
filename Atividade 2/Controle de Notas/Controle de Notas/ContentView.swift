import SwiftUI

// MARK: - Modelo

struct Aluno: Identifiable {
    let id = UUID()
    let nome: String
    let nota1: Double
    let nota2: Double

    var media: Double {
        (nota1 + nota2) / 2
    }

    var aprovado: Bool {
        media >= 7.0
    }

    var situacao: String {
        aprovado ? "Aprovado" : "Reprovado"
    }
}

// MARK: - Tela principal

struct ContentView: View {

    // Campos do formulário
    @State private var nome = ""
    @State private var nota1 = ""
    @State private var nota2 = ""

    // Lista mantida somente em memória
    @State private var alunos: [Aluno] = []

    // Alerta de validação
    @State private var mostrarAlerta = false
    @State private var mensagemAlerta = ""

    // Resumo da turma
    private var quantidadeAprovados: Int {
        alunos.filter { $0.aprovado }.count
    }

    private var quantidadeReprovados: Int {
        alunos.filter { !$0.aprovado }.count
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {

                cabecalho

                formularioCadastro

                resumoTurma

                listagemAlunos
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .alert("Atenção", isPresented: $mostrarAlerta) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(mensagemAlerta)
        }
    }

    // MARK: - Cabeçalho

    private var cabecalho: some View {
        VStack(spacing: 12) {
            Image(systemName: "graduationcap.fill")
                .font(.system(size: 55))
                .foregroundStyle(.orange)

            Text("Minha Turma")
                .font(.largeTitle)
                .bold()

            Text("Cadastre alunos e acompanhe os resultados.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 20)
    }

    // MARK: - Formulário

    private var formularioCadastro: some View {
        VStack(alignment: .leading, spacing: 18) {

            Label("Cadastrar aluno", systemImage: "person.badge.plus")
                .font(.title2)
                .bold()

            VStack(alignment: .leading, spacing: 8) {
                Text("Nome do aluno")
                    .font(.headline)

                TextField("Digite o nome completo", text: $nome)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
            }

            HStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nota 1")
                        .font(.headline)

                    TextField("0 a 10", text: $nota1)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Nota 2")
                        .font(.headline)

                    TextField("0 a 10", text: $nota2)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                }
            }

            Button {
                cadastrarAluno()
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")

                    Text("Cadastrar aluno")
                        .bold()
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.orange)
                .clipShape(
                    RoundedRectangle(cornerRadius: 14)
                )
            }
        }
        .padding()
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
        .shadow(
            color: .black.opacity(0.08),
            radius: 8,
            x: 0,
            y: 4
        )
    }

    // MARK: - Resumo

    private var resumoTurma: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Resumo da turma")
                .font(.title2)
                .bold()

            HStack {
                ResumoItemView(
                    imagem: "person.3.fill",
                    cor: .blue,
                    quantidade: alunos.count,
                    titulo: "Alunos"
                )

                Spacer()

                ResumoItemView(
                    imagem: "checkmark.circle.fill",
                    cor: .green,
                    quantidade: quantidadeAprovados,
                    titulo: "Aprovados"
                )

                Spacer()

                ResumoItemView(
                    imagem: "xmark.circle.fill",
                    cor: .red,
                    quantidade: quantidadeReprovados,
                    titulo: "Reprovados"
                )
            }
        }
        .padding()
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
        .shadow(
            color: .black.opacity(0.08),
            radius: 8,
            x: 0,
            y: 4
        )
    }

    // MARK: - Listagem

    private var listagemAlunos: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Alunos cadastrados")
                    .font(.title2)
                    .bold()

                Spacer()

                Text("\(alunos.count) registros")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            if alunos.isEmpty {
                VStack(spacing: 14) {
                    Image(systemName: "person.crop.rectangle.stack")
                        .font(.system(size: 55))
                        .foregroundStyle(.secondary)

                    Text("Nenhum aluno cadastrado")
                        .font(.headline)

                    Text("Preencha o formulário para adicionar o primeiro aluno.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 35)
            } else {
                VStack(spacing: 15) {
                    ForEach(alunos) { aluno in
                        AlunoCardView(
                            aluno: aluno,
                            removerAluno: {
                                removerAluno(aluno)
                            }
                        )
                    }
                }
            }
        }
    }

    // MARK: - Funções

    private func cadastrarAluno() {
        let nomeTratado = nome.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !nomeTratado.isEmpty else {
            exibirErro("Informe o nome do aluno.")
            return
        }

        guard let primeiraNota = converterNota(nota1) else {
            exibirErro("Informe uma Nota 1 válida.")
            return
        }

        guard let segundaNota = converterNota(nota2) else {
            exibirErro("Informe uma Nota 2 válida.")
            return
        }

        guard primeiraNota >= 0 && primeiraNota <= 10 else {
            exibirErro("A Nota 1 deverá estar entre 0 e 10.")
            return
        }

        guard segundaNota >= 0 && segundaNota <= 10 else {
            exibirErro("A Nota 2 deverá estar entre 0 e 10.")
            return
        }

        let novoAluno = Aluno(
            nome: nomeTratado,
            nota1: primeiraNota,
            nota2: segundaNota
        )

        alunos.append(novoAluno)

        limparCampos()
    }

    private func converterNota(_ texto: String) -> Double? {
        let textoTratado = texto.replacingOccurrences(
            of: ",",
            with: "."
        )

        return Double(textoTratado)
    }

    private func removerAluno(_ aluno: Aluno) {
        alunos.removeAll { item in
            item.id == aluno.id
        }
    }

    private func limparCampos() {
        nome = ""
        nota1 = ""
        nota2 = ""
    }

    private func exibirErro(_ mensagem: String) {
        mensagemAlerta = mensagem
        mostrarAlerta = true
    }
}

// MARK: - Componente do resumo

struct ResumoItemView: View {
    let imagem: String
    let cor: Color
    let quantidade: Int
    let titulo: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imagem)
                .font(.title2)
                .foregroundStyle(cor)

            Text("\(quantidade)")
                .font(.title)
                .bold()

            Text(titulo)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Componente do aluno

struct AlunoCardView: View {
    let aluno: Aluno
    let removerAluno: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(aluno.nome)
                        .font(.headline)

                    Text(aluno.situacao)
                        .font(.caption)
                        .bold()
                        .foregroundStyle(
                            aluno.aprovado ? .green : .red
                        )
                }

                Spacer()

                Button(role: .destructive) {
                    removerAluno()
                } label: {
                    Image(systemName: "trash")
                        .font(.title3)
                }
            }

            Divider()

            HStack {
                NotaItemView(
                    titulo: "Nota 1",
                    valor: aluno.nota1
                )

                Spacer()

                NotaItemView(
                    titulo: "Nota 2",
                    valor: aluno.nota2
                )

                Spacer()

                NotaItemView(
                    titulo: "Média",
                    valor: aluno.media
                )
            }

            HStack {
                Image(
                    systemName: aluno.aprovado
                        ? "checkmark.circle.fill"
                        : "xmark.circle.fill"
                )

                Text(
                    aluno.aprovado
                        ? "Aluno aprovado"
                        : "Aluno reprovado"
                )
            }
            .font(.subheadline)
            .bold()
            .foregroundStyle(
                aluno.aprovado ? .green : .red
            )
        }
        .padding()
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    aluno.aprovado
                        ? Color.green.opacity(0.35)
                        : Color.red.opacity(0.35),
                    lineWidth: 1
                )
        }
    }
}

// MARK: - Componente de nota

struct NotaItemView: View {
    let titulo: String
    let valor: Double

    var body: some View {
        VStack(spacing: 5) {
            Text(titulo)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(valor, format: .number.precision(.fractionLength(1)))
                .font(.headline)
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
