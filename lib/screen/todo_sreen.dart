import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.1,
        // shadowColor: Colors.black26,
        backgroundColor: provider.isDarkTheme ? Colors.black : Colors.white70,
        elevation: 4,
        leading: IconButton(
          icon: Icon(
            provider.isDarkTheme ? Icons.dark_mode : Icons.light_mode,
            size: 23,
          ),
          onPressed: provider.screenTheme,
        ),
        centerTitle: true,
        title: const Text(
          'Todo',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(provider.isGrid ? Icons.list : Icons.grid_view,
                  size: 23),
              onPressed: provider.screenView),
        ],
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {
          if (provider.todos.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
                color: Colors.redAccent,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: provider.isGrid
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemBuilder: (context, index) =>
                        buildCardTwo(provider, index, context),
                  )
                : ListView.builder(
                    itemCount: provider.todos.length,
                    itemBuilder: (context, index) {
                      return buildCard(provider, index, context);
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget buildCard(TodoProvider provider, int index, BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17), // Rounded corners
          side: BorderSide(
              color: provider.isDarkTheme == false
                  ? provider.todos[index].completed
                      ? Colors.green
                      : Colors.red
                  : provider.isDarkTheme == true
                      ? Colors.blue
                      : Colors.black,
              width: 2), // Border
        ),
        trailing: Icon(
          provider.todos[index].completed
              ? Icons.check_circle
              : Icons.pending_sharp,
          size: 30,
          color: provider.todos[index].completed ? Colors.green : Colors.red,
        ),
        title: Text(
          provider.todos[index].title.toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Provider.of<TodoProvider>(context).isDarkTheme
                ? Colors.white
                : Colors.black,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          provider.todos[index].completed ? 'Completed' : 'Pending',
          style: TextStyle(
            color: provider.todos[index].completed ? Colors.green : Colors.red,
            fontWeight: FontWeight.w400,
          ),
        ),
        tileColor: Provider.of<TodoProvider>(context).isDarkTheme == false
            ? provider.todos[index].completed
                ? Colors.green.shade50
                : Colors.red.shade50
            : Provider.of<TodoProvider>(context).isDarkTheme == true
                ? Colors.grey[800]
                : Colors.black,
      ),
    );
  }

  Widget buildCardTwo(TodoProvider provider, int index, BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17), // Rounded corners
          side: BorderSide(
              color: provider.isDarkTheme == false
                  ? provider.todos[index].completed
                      ? Colors.green
                      : Colors.red
                  : provider.isDarkTheme == true
                      ? Colors.grey
                      : Colors.black,
              width: 2), // Border
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                provider.todos[index].completed ? 'Completed' : 'Pending',
                style: TextStyle(
                  color: provider.todos[index].completed
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Icon(
                provider.todos[index].completed
                    ? Icons.check_circle
                    : Icons.pending_sharp,
                size: 25,
                color:
                    provider.todos[index].completed ? Colors.green : Colors.red,
              ),
            ],
          ),
        ),
        subtitle: Text(
          provider.todos[index].title.toString(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Provider.of<TodoProvider>(context).isDarkTheme
                ? Colors.white
                : Colors.black,
          ),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
        tileColor: Provider.of<TodoProvider>(context).isDarkTheme == false
            ? provider.todos[index].completed
                ? Colors.green.shade50
                : Colors.red.shade50
            : Provider.of<TodoProvider>(context).isDarkTheme == true
                ? Colors.grey[800]
                : Colors.black,
      ),
    );
  }
}
