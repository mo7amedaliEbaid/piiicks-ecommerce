import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piiicks/presentation/screens/categories.dart';
import 'package:piiicks/shared/constant/strings.dart';
import 'application/categories_bloc/category_bloc.dart';
import 'shared/di/di.dart' as di;


void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = true;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
  configLoading();
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          di.sl<CategoryBloc>()..add(const GetCategories()),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: appTitle,
          theme: ThemeData.light(),
          builder: EasyLoading.init(),
        home: CategoriesScreen(),
        ),
    );
  }
}


