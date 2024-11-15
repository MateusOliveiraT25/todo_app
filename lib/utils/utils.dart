import 'package:flutter/material.dart';

/// Função para validar um campo de texto não vazio
bool validarCampoNaoVazio(String texto) {
  return texto.isNotEmpty;
}

/// Função para formatar a data no formato `dd/MM/yyyy`
String formatarData(String data) {
  try {
    DateTime dateTime = DateTime.parse(data);
    return "${dateTime.day.toString().padLeft(2, '0')}/"
           "${dateTime.month.toString().padLeft(2, '0')}/"
           "${dateTime.year}";
  } catch (e) {
    return data;  // Retorna a data original em caso de erro
  }
}

/// Função para exibir Snackbar
void exibirSnackbar(BuildContext context, String mensagem) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(mensagem)),
  );
}
