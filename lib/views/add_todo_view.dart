import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/todo_controller.dart';
import 'package:todo_getx/models/todo_model.dart';

class AddTodoView extends StatefulWidget {
  AddTodoView({super.key, this.todo});

  TodoModel? todo;

  @override
  _AddTodoViewState createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  final TodoController todoController = Get.put(TodoController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  bool isLoading = false; // ตัวแปรป้องกันการกดซ้ำ

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      titleController.text = widget.todo!.title;
      subtitleController.text = widget.todo!.subtitle;
    }
  }

  void _saveTodo() async {
    if (isLoading) return; // ป้องกันการกดซ้ำ

    if (titleController.text.isEmpty) {
      Get.snackbar(
        'ข้อมูลไม่ครบ',
        'กรุณากรอกข้อมูลให้ครบถ้วน',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.3),
        colorText: Colors.white,
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    if (widget.todo != null) {
      widget.todo!.title = titleController.text;
      widget.todo!.subtitle = subtitleController.text;
      await todoController.updateTodo(widget.todo!);
    } else {
      await todoController.addTodo(
        titleController.text,
        subtitleController.text,
      );
    }

    Get.back();
    Get.snackbar(
      'แจ้งเตือน',
      'บันทึกข้อมูลเรียบร้อยแล้ว',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.withOpacity(0.3),
      colorText: Colors.white,
    );

    await Future.delayed(const Duration(seconds: 1)); // หน่วงเวลา
    setState(() {
      isLoading = false; // เปิดให้กดได้อีกครั้ง
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.todo != null ? 'แก้ไขรายการ Todo' : 'เพิ่มรายการ Todo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightGreen[900],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ชื่อรายการ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'กรอกชื่อรายการ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'รายละเอียด',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: subtitleController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'กรอกรายละเอียดเพิ่มเติม',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        isLoading
                            ? null
                            : _saveTodo, // ปิดปุ่มถ้า isLoading = true
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child:
                        isLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              'บันทึก',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
