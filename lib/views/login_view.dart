import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:todo_getx/controllers/auth_controller.dart';
import 'package:todo_getx/views/register_view.dart';
import 'package:todo_getx/widgets/app_textfield.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "เข้าสู่ระบบ",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightGreen[900],
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(label: "Email", controller: emailController),
            const SizedBox(height: 15),
            AppTextField(
              label: "Password",
              controller: passwordController,
              hidetext: true,
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen[800],
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (!GetUtils.isEmail(emailController.text)) {
                  Get.snackbar(
                    "Error",
                    "กรุณากรอกอีเมลให้ถูกต้อง",
                    backgroundColor: Colors.redAccent.withOpacity(0.3),
                    colorText: Colors.white,
                  );
                  return;
                }
                if (passwordController.text.length < 6) {
                  Get.snackbar(
                    "Error",
                    "กรุณากรอกรหัสผ่านให้ครบ อย่างน้อย 6 ตัว",
                    backgroundColor: Colors.redAccent.withOpacity(0.3),
                    colorText: Colors.white,
                  );
                  return;
                }

                authController.login(
                  emailController.text,
                  passwordController.text,
                );
              },
              child: const Text(
                "เข้าสู่ระบบ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen[800],
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Get.to(RegisterView());
              },
              child: const Text(
                "สมัครสมาชิก",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
