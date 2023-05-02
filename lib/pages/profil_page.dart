import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_bloc_advanced/bloc/user_bloc.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = context.read<UserBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text("Profil user")),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // BlocBuilder<UserBloc, Map<String, dynamic>>(
            //   bloc: userBloc,
            //   builder: (context, state) {
            //     print("Nama dibuild ");
            //     return Text("Nama : ${state['name']} ");
            //   },
            // ),
            // BlocBuilder<UserBloc, Map<String, dynamic>>(
            //   bloc: userBloc,
            //   builder: (context, state) {
            //     print("Umur dibuild ");
            //     return Text("Umur : ${state['age']} Tahun");
            //   },
            // ),
            BlocSelector<UserBloc, Map<String, dynamic>, String>(
              selector: (state) {
                return state['name'];
              },
              builder: (context, state) {
                print("Nama build");
                return Text("Nama : $state");
              },
            ),
            BlocSelector<UserBloc, Map<String, dynamic>, int>(
              selector: (state) {
                return state['age'];
              },
              builder: (context, state) {
                print("Umur build");
                return Text("Umur : $state Tahun");
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => userBloc.changeName(value),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    userBloc.changeAge(userBloc.state["age"] - 1);
                  },
                  icon: const Icon(Icons.remove),
                ),
                IconButton(
                  onPressed: () {
                    userBloc.changeAge(userBloc.state["age"] + 1);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
