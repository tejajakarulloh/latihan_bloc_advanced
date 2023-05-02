import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_bloc_advanced/bloc/counter_bloc.dart';
import 'package:latihan_bloc_advanced/bloc/theme_bloc.dart';
import 'package:latihan_bloc_advanced/bloc/user_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeBloc themeBloc = context.read<ThemeBloc>();
    UserBloc userBloc = context.read<UserBloc>();

    // CounterBloc counterBloc = context.read<CounterBloc>(); // baca 1 x
    // CounterBloc counterBloc = context.read<CounterBloc>(); // baca tiap state berubah kekurangn rebuild context yang dituju
    // rebuild context yang dituju , kalo mau gk rebuild wrap make builder
    String nameUser =
        context.select<UserBloc, String>((value) => value.state["name"]);
    int ageUser = context.select<UserBloc, int>((value) => value.state["age"]);

    print("BUild scaffold");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(nameUser),
            Text(ageUser.toString()),
            MultiBlocListener(
              listeners: [
                BlocListener<ThemeBloc, bool>(
                  listener: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text("TEMA GELAP AKTIF "),
                      ),
                    );
                  },
                  listenWhen: (previous, current) {
                    if (current == false) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                ),
                BlocListener<CounterBloc, int>(
                  listener: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text("Di atas 10 "),
                      ),
                    );
                  },
                  listenWhen: (previous, current) {
                    if (current > 10) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                ),
              ],
              child: Builder(
                builder: (context) {
                  // baca tiap state berubah
                  UserBloc userBloc = context.watch<UserBloc>();
                  return Text(
                    userBloc.state["age"].toString(),
                    style: const TextStyle(fontSize: 50),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    // context.read<CounterBloc>().decrement();
                    userBloc.changeAge(userBloc.state["age"] - 1);
                  },
                  icon: const Icon(Icons.remove),
                ),
                IconButton(
                  onPressed: () {
                    // context.read<CounterBloc>().increment();
                    userBloc.changeAge(userBloc.state["age"] + 1);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          themeBloc.changeTheme();
        },
      ),
    );
  }
}
