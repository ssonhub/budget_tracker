import 'package:budget_tracker/screens/home.dart';
import 'package:budget_tracker/services/budget_service.dart';
import 'package:budget_tracker/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* You probably notice that every time you Hot Restart your application,
all the data, and settings such as Dark mode are wiped. That's because all the
state is being saved in memory and once your application restarts, it gets cleared

That's when shared_preferences comes in. Shared Preferences is a great package
that provides a siimple but persistent data storage mechnism for our app.
Stores data locally in the device

We can used shared_preferences to save small bits of data such as bool, String,
int etc. To use it, we can simply initalize it by getting an instance of it
-> // Obtain shared preferences
final prefs = await SharedPreferences.getInstance();

If we wanted to save a variable in local storage, we can simply do: //
Save an integer value to the 'counter' key. await prefs.setInt('counter', 10);

-> // Save an integer value to 'counter' key
await prefs.setInt('counter', 10);

This will save an integar 10 that is mapped to a key counter. So if you want to
retrieve it, we can simply do
-> // Try reading data from the 'counter' key. If it doesn't exist, returns null
final int? counter = prefs.getInt('counter);

This will try to get the value inside the key counter. if it fails, it will return
null. To avoid failure, we can have a default value assigned to it using the
?? operator
-> // Reading data from the 'counter' key. If it doesn't exist, returns 0
final int counter = prefs.getInt('counter') ?? 0;
 */

void main() async {
  /* Let's edit the main function to be able to initialize shared preferences,
  so we don't have to do it every time we want to save a property
  
  Before we can get the shared preferences instance like shown above, we need to
  call WidgetsFlutterBinding.ensureInitialized();
  Because shared preferences interact with native platform code,
  we need to call this function to ensure that there is a glue between the widgets
  layer and the Flutter engine */

  /* We need to make our main() async as SharedPreferences.getInstance() returns
  a Future
  */
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  return runApp(MyApp(
    // Let's now pass our sharedPreferences to MyApp() by passing it as a parameter
    sharedPreferences: sharedPreferences,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const MyApp({required this.sharedPreferences, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /* Now pass the sharedPreferences to our ThemeService provider when
        we create it. This will ensure ThemeService has access every time
        to sharedPreferences when need it. */
        ChangeNotifierProvider<ThemeService>(
            create: (_) => ThemeService(sharedPreferences)),
        ChangeNotifierProvider<BudgetService>(create: (_) => BudgetService()),
      ],
      child: Builder(builder: (BuildContext context) {
        final themeService = Provider.of<ThemeService>(context);
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.indigo,
                brightness:
                    themeService.darkTheme ? Brightness.dark : Brightness.light,
              ),
            ),
            home: const Home());
      }),
    );
  }
}
