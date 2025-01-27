import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_learning_app/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:tdd_learning_app/src/authentication/presentation/widgets/add_user_dialog.dart';
import 'package:tdd_learning_app/src/authentication/presentation/widgets/loading_column.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() {
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if(state is AuthenticationError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }else if(state is UserCreated) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GettingUser ? LoadingColumn(message: 'Fetching Users') :
            state is CreatingUser ? LoadingColumn(message: 'Creating User') :
            state is UsersLoaded ? Center(child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  // leading: Image.network(user.avatar),
                  title: Text(user.name),
                  subtitle: Text(user.createdAt.substring(0, 10)),
                );
              })) : SizedBox.shrink(),
          appBar: AppBar(title: Text("Home"),),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog(
                  context: context, builder: (context) => AddUserDialog(nameController: nameController));
            }, label: Text('Add User'), icon: Icon(Icons.add),),
        );
      },
    );
  }
}
