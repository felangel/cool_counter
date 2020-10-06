import 'package:cool_counter/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedCubit.storage = await HydratedStorage.build();
  runApp(CoolCounterApp());
}

class CoolCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterCubit(),
        child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cool Counter 😎'),
        actions: [
          BlocBuilder<CounterCubit, int>(
            builder: (context, state) {
              final cubit = context.bloc<CounterCubit>();
              return IconButton(
                icon: const Icon(Icons.undo),
                onPressed: cubit.canUndo ? cubit.undo : null,
              );
            },
          ),
          BlocBuilder<CounterCubit, int>(
            builder: (context, state) {
              final cubit = context.bloc<CounterCubit>();
              return IconButton(
                icon: const Icon(Icons.redo),
                onPressed: cubit.canRedo ? cubit.redo : null,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Text('$state', style: textTheme.headline1);
          },
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => context.bloc<CounterCubit>().increment(),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () => context.bloc<CounterCubit>().decrement(),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            child: Icon(Icons.clear),
            onPressed: () => context.bloc<CounterCubit>().reset(),
          ),
        ],
      ),
    );
  }
}
