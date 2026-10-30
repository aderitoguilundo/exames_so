import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(const MaisSaberApp());

class MaisSaberApp extends StatelessWidget {
  const MaisSaberApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mais Saber',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF8B0000), scaffoldBackgroundColor: Colors.white),
      home: const TelaInicial(),
    );
  }
}

// ===== BASE DE DADOS =====
class DatabaseHelper {
  static Database? _db;
  Future<Database> get database async {
    if (_db != null) return _db!;
    String path = join(await getDatabasesPath(), 'mais_saber.db');
    _db = await openDatabase(path, version: 1, onCreate: (db, v) async {
      await db.execute('CREATE TABLE exames(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, classe TEXT, ano INTEGER)');
      await db.execute('CREATE TABLE livros(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, classe TEXT)');
      // DADOS INICIAIS PARA TESTE
      await db.insert('exames', {'titulo': 'Matemática', 'classe': '9a Classe', 'ano': 2023});
      await db.insert('exames', {'titulo': 'Biologia', 'classe': '12a Classe', 'ano': 2024});
      await db.insert('exames', {'titulo': 'Português', 'classe': '6a Classe', 'ano': 2022});
      await db.insert('livros', {'titulo': 'Matemática 9a - Longman', 'classe': '9a Classe'});
    });
    return _db!;
  }
  Future<List<Map<String, dynamic>>> listarExames() async {
    final db = await database;
    return await db.query('exames');
  }
  Future<List<Map<String, dynamic>>> listarLivros() async {
    final db = await database;
    return await db.query('livros');
  }
}

// ===== TELA INICIAL - IGUAL SUA FOTO =====
class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black, size: 26),
        title: Row(children: const [
          Text("+S", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
          SizedBox(width: 6),
          Text("Mais\nSaber", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF8B0000), height: 1)),
        ]),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          Row(children: [
            Expanded(child: _botao(context, "Exames", const ListaExamesPage())),
            const SizedBox(width: 8),
            Expanded(child: _botao(context, "Guia", const ListaLivrosPage())),
            const SizedBox(width: 8),
            Expanded(child: _botao(context, "Livros", const ListaLivrosPage())),
          ]),
          const SizedBox(height: 20),
          const Text("Dados agora vêm da Base de Dados SQLite", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ]),
      ),
    );
  }
  static Widget _botao(BuildContext ctx, String texto, Widget destino) {
    return InkWell(
      onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => destino)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(border: Border.all(color: Colors.black54, width: 1), borderRadius: BorderRadius.circular(6)),
        child: Center(child: Text(texto, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500))),
      ),
    );
  }
}

// ===== LISTA DE EXAMES VINDO DA BASE =====
class ListaExamesPage extends StatelessWidget {
  const ListaExamesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exames - Base de Dados")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper().listarExames(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          var exames = snapshot.data!;
          return ListView.builder(
            itemCount: exames.length,
            itemBuilder: (_, i) => Card(child: ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Color(0xFF8B0000)),
              title: Text(exames[i]['titulo']),
              subtitle: Text("${exames[i]['classe']} - ${exames[i]['ano']}"),
              trailing: const Icon(Icons.chevron_right),
            )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DatabaseHelper().database.then((db) => db.insert('exames', {'titulo': 'Novo Exame', 'classe': '10a Classe', 'ano': 2025}));
          (context as Element).markNeedsBuild();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListaLivrosPage extends StatelessWidget {
  const ListaLivrosPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Livros - Base de Dados")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper().listarLivros(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          var livros = snapshot.data!;
          return ListView.builder(
            itemCount: livros.length,
            itemBuilder: (_, i) => ListTile(title: Text(livros[i]['titulo']), subtitle: Text(livros[i]['classe'])),
          );
        },
      ),
    );
  }
}