import 'package:bloc_state_management/counter_cubit/views/counter_cubit_page.dart';
import 'package:bloc_state_management/counter_riverpod/provider/counter_provider.dart';
import 'package:bloc_state_management/counter_riverpod/views/counter_riverpod_page.dart';
import 'package:bloc_state_management/repposites/placeholder_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'counter_bloc/views/counter_bloc_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final status = await (Connectivity().checkConnectivity());
  runApp(
    ProviderScope(
      overrides: [
        placeholderRepositoryProvider.overrideWith(
          (ref) => status == ConnectivityResult.none
              ? TestPlaceholderRepository()
              : RemotePlaceholderRepository(ref),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => TestPlaceholderRepository(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyRoot(),
      ),
    );
  }
}

class MyRoot extends StatefulWidget {
  const MyRoot({super.key});

  @override
  State<MyRoot> createState() => _MyRootState();
}

class _MyRootState extends State<MyRoot> {
  int navigationId = 0;

  @override
  Widget build(BuildContext context) {
    final repo = context.read<TestPlaceholderRepository>();
    final screens = [
      const CounterRiverpodPage(),
      const CounterBlocPage(),
      const CounterCubitPage(),
    ];

    return Scaffold(
      body: IndexedStack(
        children: screens,
        index: navigationId,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationId,
        onDestinationSelected: (value) => setState(() {
          navigationId = value;
        }),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Riverpod',
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Bloc',
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Cubit',
          ),
        ],
      ),
    );
  }
}
