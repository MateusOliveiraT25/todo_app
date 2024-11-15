import 'package:flutter/material.dart';

class DropdownPrioridade extends StatelessWidget {
  final String prioridade;
  final ValueChanged<String?> onChanged;

  const DropdownPrioridade({
    required this.prioridade,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: prioridade,
      onChanged: onChanged,
      items: ['baixa', 'média', 'alta']
          .map((prioridade) => DropdownMenuItem<String>(
                value: prioridade,
                child: Text(prioridade),
              ))
          .toList(),
      hint: Text('Selecione a Prioridade'),
    );
  }
}
