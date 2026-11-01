# +S Mais Saber

Aplicativo Android de estudo para alunos moçambicanos, onde será possível consultar e descarregar exames anteriores, guias de estudo e livros, de várias disciplinas e classes.

> 🚧 Em desenvolvimento. Por enquanto só existe a tela inicial.

## Sobre o projecto

Muitos alunos têm dificuldade em encontrar provas e materiais de estudo organizados num só lugar. O **Mais Saber** quer resolver isso: um app leve, simples e que funcione também **offline**, pensado para quem tem dados móveis limitados.

## Funcionalidades

*Já feito:*
- [x] Tela inicial com cabeçalho, botões *Exames*, *Guia* e *Livros* e caixa de conteúdo

**Planeadas**
- [ ] Lista de exames com filtro por classe e disciplina
- [ ] Pesquisa de exames
- [ ] Download e leitura de PDFs dentro do app
- [ ] Acesso offline aos ficheiros descarregados
- [ ] Guia de estudo (técnicas, planeamento, dicas)
- [ ] Biblioteca de livros por classe
- [ ] Menu lateral e página de perfil
- [ ] Servidor (backend) para actualizar o conteúdo sem reinstalar o app

## Tecnologias

- [Flutter](https://flutter.dev) e Dart (interface do app)
- SQLite (`sqflite`), previsto para guardar os dados localmente
- Python (FastAPI), previsto para o servidor

## Como executar

Pré-requisitos: [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado e um emulador Android ou telemóvel com depuração USB.

***bash
git clone https://github.com/aderitoguilundo/exames_so.git
cd exames_so
flutter pub get
flutter run
```

## Estrutura do projecto
``
exames_so/
├── android/        # projecto Android
├── ios/            # projecto iOS
├── lib/
│   └── main.dart   # código principal do app
├── test/           # testes
├── web/            # versão web
├── pubspec.yaml    # dependências
└── README.md
```

## Design

O esboço inicial da interface foi desenhado à mão: cabeçalho com o nome do app e o menu, três botões (Exames, Guia, Livros) e uma área grande para o conteúdo. Cores: fundo branco, texto preto e "Mais Saber" em azul.

## Autor

**Adérito Guilundo**, Moçambique
GitHub: [@aderitoguilundo](https://github.com/aderitoguilundo)

## Licença

Projecto pessoal. Licença ainda por definir.
