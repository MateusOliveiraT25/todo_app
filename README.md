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

1. **Flutter instalado**: [Instalar Flutter](https://docs.flutter.dev/get-started/install)
2. **Configuração do Firebase para Flutter**: [Configurar Firebase](https://firebase.google.com/docs/flutter/setup)

### Passos para Rodar o Projeto

1. Clone este repositório:
    ```bash
   git clone https://github.com/MateusOliveiraT25/todo_app.git

2. Navegue até a pasta do projeto:
     ```bash
   cd todo_app
     
4. Instale as dependências:
    ```bash
   flutter pub get
    
6. **Configure o Firebase para o projeto:**

   Siga as instruções do Firebase para adicionar um projeto iOS e Android.

   - Acesse o [Firebase Console](https://console.firebase.google.com/).
   - Crie um novo projeto ou use um existente.
   - Adicione os aplicativos Android e iOS ao seu projeto Firebase:
     - Para Android:
       - Registre o aplicativo Android no Firebase.
       - Baixe o arquivo `google-services.json`.
       - Coloque o arquivo `google-services.json` na pasta `android/app` do seu projeto Flutter.
     - Para iOS:
       - Registre o aplicativo iOS no Firebase.
       - Baixe o arquivo `GoogleService-Info.plist`.
       - Coloque o arquivo `GoogleService-Info.plist` na pasta `ios/Runner` do seu projeto Flutter.
   
   - **Atualize os arquivos de configuração do Android:**
     - Abra o arquivo `android/build.gradle` e adicione o seguinte código dentro do bloco `buildscript`:
       ```gradle
       dependencies {
           classpath 'com.google.gms:google-services:4.3.3'  // Adicione esta linha
       }
       ```
     - Abra o arquivo `android/app/build.gradle` e adicione a seguinte linha no final do arquivo:
       ```gradle
       apply plugin: 'com.google.gms.google-services'  // Adicione esta linha
       ```

   - **Atualize os arquivos de configuração do iOS (se aplicável):**
     - Abra o terminal na raiz do seu projeto e execute o seguinte comando para instalar as dependências do Firebase no iOS:
       ```bash
       flutter pub get
       ```

   Agora o seu projeto está configurado para usar o Firebase! Prossiga para o próximo passo para rodar o aplicativo.


8. Execute o aplicativo:
  ```bash
flutter run

