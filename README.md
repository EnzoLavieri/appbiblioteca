# Biblioteca Pessoal

Um aplicativo de gerenciamento de biblioteca desenvolvido em Flutter. O aplicativo permite aos usuários adicionar, editar, visualizar e excluir livros e autores, com a opção de marcar livros como favoritos. Ele possui funcionalidades CRUD completas para ambas as entidades e uma interface de usuário intuitiva.

## Estrutura do Projeto

### 1. Pasta `models`
- **`Livro`**: Classe que representa os dados de um livro, incluindo título, descrição, nota, autor e status de favorito.
- **`Autor`**: Classe que representa os dados de um autor, incluindo nome e nacionalidade.

### 2. Pasta `screens`
- **`DashboardScreen`**: Tela principal com um menu de navegação lateral (`Drawer`) que permite acessar a lista de livros, adicionar um livro e adicionar um autor.
- **`LivrosScreen`**: Tela que exibe a lista de livros. Inclui funcionalidades para marcar como favorito, editar e excluir livros, com abas para alternar entre todos os livros e os livros favoritos.
- **`FormularioLivroScreen`**: Tela de formulário para adicionar ou editar livros, com campos para título, descrição, nota e seleção de autor.
- **`FormularioAutorScreen`**: Tela de formulário para adicionar ou editar autores, com campos para ID, nome e nacionalidade.

### 3. Pasta `services`
- **`ApiService`**: Serviço responsável pelas chamadas de API. Lida com as operações CRUD para autores e livros.

## Como Inicializar o Projeto

### Pré-requisitos
- Instale o [Flutter SDK](https://flutter.dev/docs/get-started/install).
- Configure o ambiente de desenvolvimento Flutter (Android Studio, VS Code ou outro editor).

### Instalação e Configuração
1. Clone o repositório ou copie o código-fonte para o seu ambiente de desenvolvimento.
    ```bash
   https://github.com/EnzoLavieri/appbiblioteca.git
2. Abra o projeto em seu editor preferido.
3. No terminal, navegue até o diretório do projeto e execute o seguinte comando para obter as dependências do Flutter:
   ```bash
   flutter pub get
4. Para guardar os livros e autores no DB json local, inicialize ele com o comando:
      ```bash
   json-server --watch db.json --port 3000
5. Por fim, para "rodar" o aplicativo em um emulador ou dispositivo físico, use o seguinte comando:
      ```bash
   flutter run
