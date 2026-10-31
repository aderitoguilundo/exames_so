import 'package:flutter/material.dart';

const Color kAzul = Color(0xFF1565C0);

void main() => runApp(const MaisSaberApp());

class MaisSaberApp extends StatelessWidget {
  const MaisSaberApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mais Saber',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: kAzul,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----- Cabeçalho: + Mais Saber  |  ☰ -----
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "+",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    "Mais\nSaber",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kAzul, height: 1.1),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.black, size: 30),
                    onPressed: () {}, // não faz nada
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // ----- Botões: Exames | Guia | Livros -----
              Row(children: [
                Expanded(child: _botao("Exames")),
                const SizedBox(width: 10),
                Expanded(child: _botao("Guia")),
                const SizedBox(width: 10),
                Expanded(child: _botao("Livros")),
              ]),
              const SizedBox(height: 14),

              // ----- Caixa grande -----
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _botao(String texto) {
    return InkWell(
      onTap: () {}, // não leva a lado nenhum
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            texto,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
      ),
    );
  }
}