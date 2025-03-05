import 'package:falcon/core/core_exports.dart';

class LoginView extends StatelessWidget {
   LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginBody(),
    );
  }
}
