import 'package:go_router/go_router.dart';

import '../../domain/entities/cat.dart';
import '../../presentation/screens/cat_list_screen.dart';
import '../../presentation/screens/cat_screen.dart';


final appRouter = GoRouter(
    initialLocation: '/',
    routes: [

      GoRoute(
        path: '/',
        builder: (context, state) => const CatListScreen(),
      ),
      GoRoute(path: '/cat',
        builder: (context, state) {
          final Cat? cat = state.extra != null ? state.extra as Cat : null;
          return CatScreen(cat: cat);
        },
      ),
    ]
);