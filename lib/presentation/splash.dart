import '../exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    navigator();
  }

  navigator() async {
    await context.read<OperationCubit>().getIndex();
    await Future.delayed(const Duration(seconds: 2), () {
      context.pushReplacementScreen(HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 150),
      ),
    );
  }
}
