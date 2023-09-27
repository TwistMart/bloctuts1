import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bloctuts1/Color%20Bloc/color_bloc.dart';
import 'package:bloctuts1/Color%20Bloc/color_state.dart';
import 'package:bloctuts1/Counter%20Bloc/counter_bloc.dart';
import 'package:bloctuts1/Counter%20Bloc/counter_event.dart';
import 'package:bloctuts1/Counter%20Bloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //  return  BlocProvider<CounterBloc>(

    //     create: (context) {
    //       return CounterBloc();
    //     },
    //     child: MaterialApp(
    //       home: HomePage(),
    //     ),
    //   );

    return MultiBlocProvider(providers: [
      BlocProvider<CounterBloc>(// first bloc == CounterBloc
          // blockProvider provides the bloc to its children

          create: (context) {
        return CounterBloc();
      }),
      BlocProvider<ColorBloc>(
        // second bloc == ColorBloc
        create: (context) {
          return ColorBloc();
        },
      )
    ], child: MaterialApp(home: MultipleProviders()));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Bloc"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<CounterBloc, CounterState>(
            // blocBuilder rebuilds the Ui based on the state
            buildWhen: (previous, current) {
              print(current.counter);
              print(previous.counter);
              return true;
            },
            builder: (context, state) {
              return Text(
                state.counter
                    .toString(), // gets the current value which is given as 0 in counter by using state
                style: TextStyle(fontSize: 20),
              );
            },
          ),
          BlocListener<CounterBloc, CounterState>(
            listenWhen: (previous, current) {
              print('current listener ===' + current.counter.toString());
              print('previous listener ===' + previous.counter.toString());

              return true;
            },
            listener: (context, state) {
              if (state.counter >= 5) {
                final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'BlocListener',
                    message:
                        'Listener is working and it is happening by triggering snackbar once that the state changes ',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.success,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }
            },
            child: Text('Listener listens'),
          ),
          SizedBox(height: 50),
          BlocConsumer<CounterBloc, CounterState>(
            // BlocConsumer is combination of BlocListener and BlocBuilder, means it diplays dialog, snackbar, and other function as case for BlocListener and rebuilds UI as for case with BlocConsumer
            builder: (context, state) {
              return Text(state.counter.toString());
            },
            listener: (context, state) {
              if (state.counter >= 1 && state.counter < 5) {
                final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: ' BlocConsumer',
                    message:
                        'Listener is working and it is happening by triggering snackbar once that the state changes ',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.success,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }
            },
          ),
          BlocSelector<CounterBloc, CounterState, bool>(
            // BlocSelector filter updates by selecting a ne value based on state
            selector: (state) {
              return state.counter >= 3 ? true : false;
            },
            builder: (context, state) {
              return Center(
                  child: TextButton(
                onPressed: () {
                  print(state);
                },
                child: Text('BlockSelector',
                    style:
                        TextStyle(color: state ? Colors.orange : Colors.red)),
              ));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  context.read<CounterBloc>().add(CounterIncrementEvent());
                },
                child: Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  context.read<CounterBloc>().add(CounterDecrementEvent());
                },
                child: Icon(Icons.remove),
              )
            ],
          )
        ],
      ),
    );
  }
}

class MultipleProviders extends StatelessWidget {
  const MultipleProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Bloc"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ColorBloc, ColorState>(
            // blocBuilder rebuilds the Ui based on the state
            buildWhen: (previous, current) {
              print(current.color);
              print(previous.color);
              return true;
            },
            builder: (context, state) {
              return TextButton(
                onPressed: () {

                  print('$state');
                },
                child: Text(
                  'MultipleProvider',
                  style: TextStyle(
                    color: state.color,
                    height: 10
                  ),
                  
                  ),
              );
            },
          ),
          BlocBuilder<CounterBloc, CounterState>(
            // blocBuilder rebuilds the Ui based on the state
            builder: (context, state) {
              return Text(state.counter.toString());
            },
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  // context.read<CounterBloc>().add(CounterIncrementEvent());
                  context.read<ColorBloc>().add(CounterIncrementEvent());
                },
                child: Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  // context.read<CounterBloc>().add(CounterDecrementEvent());
                  context.read<ColorBloc>().add(CounterDecrementEvent());
                },
                child: Icon(Icons.remove),
              )
            ],
          )
        ],
      ),
    );
  }
}
