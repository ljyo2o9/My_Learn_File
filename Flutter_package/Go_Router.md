## G****o_router****

- Router 설정
    
    ```dart
    import 'package:go_router/go_router.dart';
    
    final GoRouter _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (_, state) => const HomePage(),
        ),
        GoRoute(
          path: '/page1',
          builder: (_, state) => const Page1(),
        ),
        GoRoute(
          path: '/page2',
          builder: (_, state) => const Page2(),
        ),
      ],
    );
    ```
    
- 초반 설정
    
    ```dart
    class MyApp extends StatelessWidget {
      const MyApp({super.key});
    
      @override
      Widget build(BuildContext context) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationProvider: _router.routeInformationProvider,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
        );
      }
    }
    ```
    
- 사용법
    
    ```dart
    import 'package:flutter/material.dart';
    import 'package:go_router/go_router.dart';
    
    class Page1 extends StatefulWidget {
      const Page1({super.key});
    
      @override
      State<Page1> createState() => _Page1State();
    }
    
    class _Page1State extends State<Page1> {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Page1')),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: MaterialButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'HomePage',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: MaterialButton(
                  onPressed: () {
                    context.go('/page2');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Page2',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
    ```