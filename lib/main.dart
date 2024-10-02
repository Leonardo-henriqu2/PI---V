import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to The Cycles'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a senha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Ação de login (validação, autenticação, etc.)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    
                    );
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responda atentamente as questões',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PerguntaAleatoria(),
    );
  }
}

class PerguntaAleatoria extends StatefulWidget {
  @override
  _PerguntaAleatoriaState createState() => _PerguntaAleatoriaState();
}

class _PerguntaAleatoriaState extends State<PerguntaAleatoria> {
  List<String> perguntas = [
    'Qual seu principal entretenimento no momento?',
    'Qual gênero mais te representa?',
    'Datas de lançamento de seu interesse?',
  ];

  Map<String, List<String>> opcoes = {
    'Qual seu principal entretenimento no momento?': ['Livros', 'Filmes', 'Series', 'Animes'],
    'Qual gênero mais te representa?': ['Ação e Aventura', 'Comédia Romântica', 'Animações em geral', 'Fatos Reais'],
    'Datas de lançamento de seu interesse?': [
      'anos 90',
      '2000 a 2009',
      '2010 a 2019',
      '2020 a 2024'
    ],
  };

  late String perguntaSelecionada;
  late String respostaSelecionada;

  @override
  void initState() {
    super.initState();
    gerarPerguntaAleatoria();
  }

  void gerarPerguntaAleatoria() {
    final random = Random();
    setState(() {
      perguntaSelecionada = perguntas[random.nextInt(perguntas.length)];
      respostaSelecionada = opcoes[perguntaSelecionada]!.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pergunta Aleatória'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              perguntaSelecionada,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Column(
              children: opcoes[perguntaSelecionada]!.map((opcao) {
                return RadioListTile<String>(
                  title: Text(opcao),
                  value: opcao,
                  groupValue: respostaSelecionada,
                  onChanged: (valor) {
                    setState(() {
                      respostaSelecionada = valor!;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Resposta Selecionada'),
                      content: Text('Você escolheu: $respostaSelecionada'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Enviar Resposta'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: gerarPerguntaAleatoria,
              child: Text('Nova Pergunta'),
            ),
          ],
        ),
      ),
    );
  }
}

