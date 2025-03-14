import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/auth_controller.dart';
import 'package:todo_getx/controllers/todo_controller.dart';
import 'package:todo_getx/models/todo_model.dart';
import 'package:todo_getx/views/add_todo_view.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TodoController todoController = Get.put(TodoController());

  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    todoController.onInit();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo List',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightGreen[900],
        foregroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authController.logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return todoController.todoList.isEmpty
              ? const Center(
                child: Text(
                  'ไม่มีรายการ Todo',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
              : ListView.builder(
                itemCount: todoController.todoList.length,
                itemBuilder: (context, index) {
                  TodoModel todo = todoController.todoList[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration:
                              todo.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      subtitle: Text(
                        todo.subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          decoration:
                              todo.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      leading: Checkbox(
                        value: todo.isDone,
                        activeColor: Colors.lightGreen[900],
                        onChanged: (bool? newValue) {
                          todoController.toggletodo(index);
                        },
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          todoController.deleteTodo(todo.docId ?? '');
                        },
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                      ),
                      onTap: () {
                        Get.to(AddTodoView(todo: todo));
                      },
                    ),
                  );
                },
              );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen[900],
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(AddTodoView());
        },
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}
