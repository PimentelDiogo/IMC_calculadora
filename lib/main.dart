import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter IMC',
      home: HomePage(
        title: '',
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController altController = TextEditingController();

  String _informacao = 'Informe os dados de Peso e Altura';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _reset() {
    setState(() {
      _informacao = 'Informe os dados de Peso e Altura!';
      _formKey = GlobalKey<FormState>();
    });
    pesoController.text = '';
    altController.text = '';
  }

  void _calculoImc() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(altController.text);
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        _informacao = 'Abaixo do peso! (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 18.6 && imc < 24.9) {
        _informacao = 'Peso ideal! (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _informacao = 'Acima do peso! (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        _informacao = 'Gordelicia! (${imc.toStringAsPrecision(4)})';
      } else if (imc > 34.9) {
        _informacao = 'Obesidade! (${imc.toStringAsPrecision(4)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Calculadora IMC'),
            centerTitle: true,
            backgroundColor: const Color(0xffe6d109),
            actions: [
              IconButton(
                onPressed: _reset,
                icon: const Icon(Icons.refresh_sharp),
              ),
            ],
          ),
          backgroundColor: Color(0xfffbf6e5),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.balance_outlined,
                      size: 120,
                      color: Color(0xffA0920A),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Peso (Kg)',
                        hintText: '50',
                        hintStyle:
                            TextStyle(color: Colors.grey.withOpacity(0.4)),
                        labelStyle: const TextStyle(
                          color: Color(0xffA0920A),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xffA0920A),
                        fontSize: 24,
                      ),
                      controller: pesoController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Inserir seu Peso';
                        }
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Altura (m)',
                        hintText: '1.60',
                        hintStyle:
                            TextStyle(color: Colors.grey.withOpacity(0.4)),
                        labelStyle: const TextStyle(
                          color: Color(0xffA0920A),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xffA0920A),
                        fontSize: 24,
                      ),
                      controller: altController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira sua Altura';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _calculoImc();
                          }
                        },
                        child: Text(
                          'Calcular ',
                          style: TextStyle(
                            color: Color(0xffA0920A),
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffe6d109),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      _informacao,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xffA0920A),
                        fontSize: 18,
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
