import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Carregando filmes',
      'Carregando populares',
      'Carregando proximos',
      'Carregando masi votados',
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const CircularProgressIndicator(),
          const SizedBox(height: 10),
          StreamBuilder(
              stream: getLoadingMessages(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) return const Text('Carregando...');

                return Text(snapshot.data!);
              }))
        ],
      ),
    );
  }
}
