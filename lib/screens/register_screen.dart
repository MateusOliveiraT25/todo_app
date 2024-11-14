import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';  // Importando a tela Home

class RegisterScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  RegisterScreen({super.key});

  Future<void> _register(BuildContext context) async {
    try {
      await _authService.signUp(_emailController.text, _passwordController.text);
      // Navegar diretamente para a HomeScreen após o registro
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Alteração para HomeScreen
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Conta criada com sucesso')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erro ao criar conta')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9C4D97), // Cor de fundo (roxo claro)
      appBar: AppBar(
        title: const Text('Criar Conta', style: TextStyle(color: Colors.white)), // Cor do título na AppBar
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
            ElevatedButton(
              onPressed: () => _register(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Cor de fundo do botão (laranja)
              ),
              child: const Text(
                'Registrar',
                style: TextStyle(color: Colors.white), // Cor do texto no botão
              ),
            ),
          ],
        ),
      ),
    );
  }
}
