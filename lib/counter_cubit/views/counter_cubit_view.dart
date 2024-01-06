import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/counter_cubit.dart';

class CounterCubitView extends StatelessWidget {
  const CounterCubitView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CounterCubit>().state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Cubit'),
      ),
      body: BlocBuilder<CounterCubit, CounterState>(
        builder: (context, state) {
          switch (state.status) {
            case BlocState.initial:
            case BlocState.loading:
              return const Center(child: CircularProgressIndicator());
            case BlocState.error:
              return Text('Error: ${state.message}');
            case BlocState.success:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      state.counter.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterCubit>().increment(10),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
