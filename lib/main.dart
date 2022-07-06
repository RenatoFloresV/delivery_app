import 'package:delivery_app/home_screen.dart';
import 'package:delivery_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'cubit/index..dart';
import 'firebase_options.dart';
import 'pages/sign_in.dart';
import 'services/repositories/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService.instance(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProductsCubit>(
              create: (context) => ProductsCubit(ProductsRepository())),
          BlocProvider<CategoriesCubit>(
              create: (context) => CategoriesCubit(CategoryRepository())),
          BlocProvider<CartProductsCubit>(
              create: (context) => CartProductsCubit(CartProductsRepository())),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Consumer(builder: (context, AuthService authService, _) {
              switch (authService.status) {
                case AuthStatus.Uninitialized:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case AuthStatus.Authenticated:
                  return const HomeScreen();
                case AuthStatus.Authenticating:
                  return const SignIn();
                case AuthStatus.Unauthenticated:
                  return const SignIn();
              }
            })),
      ),
    );
  }
}
