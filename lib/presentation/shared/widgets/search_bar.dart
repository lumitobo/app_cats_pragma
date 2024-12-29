import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/catProvider.dart';

class CustomSearchBar extends ConsumerStatefulWidget {
  const CustomSearchBar({super.key});

  @override
  ConsumerState<CustomSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<CustomSearchBar> {
  final TextEditingController searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final catState = ref.watch(catProvider);
    return SearchBar(
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: 20.0),
      ),
      controller: searchBarController,
      hintText: 'Search cats...',
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onChanged: ref.read(catProvider.notifier).searchCats,
      leading: const Icon(Icons.search),
      trailing: <Widget>[
        IconButton(
          onPressed: () {
            searchBarController.text = '';
            ref.read(catProvider.notifier).searchCats('');
          },
          icon: catState.search != '' ? const Icon(Icons.close_rounded) : const SizedBox(),
        )
      ],

    );
  }
}
