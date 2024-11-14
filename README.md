# Todo App

Este é um aplicativo de lista de tarefas desenvolvido em Flutter com integração ao Firebase. O objetivo do app é permitir que os usuários criem, editem, completem e excluam tarefas de maneira simples e prática.

## Tecnologias Utilizadas

- **Flutter**: Framework para desenvolvimento de aplicativos multiplataforma.
- **Firebase Authentication**: Autenticação de usuários.
- **Cloud Firestore**: Banco de dados em tempo real para armazenamento das tarefas dos usuários.

## Funcionalidades

- **Cadastro e Login de Usuários**: Integração com Firebase Authentication para autenticação segura dos usuários.
- **Adicionar Tarefas**: Permite criar uma nova tarefa e associá-la ao usuário autenticado.
- **Editar Tarefas**: Atualização do nome de uma tarefa existente.
- **Marcar como Concluída**: Opção para marcar uma tarefa como concluída ou não concluída.
- **Excluir Tarefas**: Permite remover uma tarefa da lista.
- **Logout**: Botão de logout que redireciona o usuário para a tela de login.

## Como Usar

### Pré-requisitos
1. Flutter instalado: [Instalar Flutter](https://docs.flutter.dev/get-started/install)
2. Configuração do Firebase para Flutter: [Configurar Firebase](https://firebase.google.com/docs/flutter/setup)

### Passos para Rodar o Projeto
1. Clone este repositório:
   ```bash
   git clone https://github.com/seu_usuario/todo_app.git
   Navegue até a pasta do projeto:
cd todo_app
Instale as dependências:
flutter pub get
Configure o Firebase para o projeto:

Siga as instruções de configuração do Firebase para adicionar um projeto iOS e Android.
Adicione o arquivo google-services.json para Android e GoogleService-Info.plist para iOS na pasta apropriada.
Atualize o arquivo android/build.gradle e android/app/build.gradle para ativar o Firebase.

Rode o aplicativo:

flutter run
Estrutura do Projeto
lib/: Contém o código principal do aplicativo.
main.dart: Arquivo inicial do aplicativo.
screens/todo_list_screen.dart: Tela principal com a lista de tarefas e as funcionalidades CRUD.
