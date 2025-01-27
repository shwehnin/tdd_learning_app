import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_learning_app/src/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  final TextEditingController nameController;
  const AddUserDialog({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'username',
                  enabledBorder: OutlineInputBorder(),
                  filled: true,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    final avatar =
                        'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1072.jpg';
                    context.read<AuthenticationCubit>().createUser(
                        name: name,
                        avatar: avatar,
                        createdAt: DateTime.now().toString());
                    Navigator.of(context).pop();
                  },
                  child: Text("Create User")),
            ],
          ),
        ),
      ),
    );
  }
}
