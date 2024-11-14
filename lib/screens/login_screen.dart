import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';  // Navegar para HomeScreen após login
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;  // Flag para indicar se o login está em andamento

  Future<void> _login(BuildContext context) async {
    setState(() {
      _isLoading = true;  // Ativa o carregamento ao iniciar o login
    });

    try {
      await _authService.signIn(_emailController.text, _passwordController.text);
      Navigator.pushReplacementNamed(context, '/home');  // Navegar para a HomeScreen usando rotas nomeadas
    } catch (e) {
      setState(() {
        _isLoading = false;  // Desativa o carregamento em caso de erro
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao fazer login: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9C4D97), // Cor de fundo (roxo claro)
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(color: Colors.white)),  // Cor do título na AppBar
        backgroundColor: Color(0xFF9C4D97), // Cor da AppBar (roxo claro)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white), // Cor do texto do label
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Cor da borda focada
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Cor da borda normal
                ),
              ),
              style: const TextStyle(color: Colors.white), // Cor do texto do campo
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(color: Colors.white), // Cor do texto do label
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Cor da borda focada
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Cor da borda normal
                ),
              ),
              obscureText: true,
              style: const TextStyle(color: Colors.white), // Cor do texto do campo
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.white))  // Exibe o indicador de carregamento
                : ElevatedButton(
                    onPressed: () => _login(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Cor de fundo do botão (laranja)
                    ),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(color: Colors.white), // Cor do texto no botão
                    ),
                  ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');  // Navegar para RegisterScreen usando rotas nomeadas
              },
              child: const Text(
                'Criar Conta',
                style: TextStyle(color: Colors.white), // Cor do texto do botão (branco)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
