import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/core/theme/text_style.dart';
import 'package:proteam_app/features/food/presentation/cubit/food_search_cubit/food_search_cubit.dart';
import 'package:proteam_app/features/food/presentation/widgets/food_list_tile_widget.dart';
import 'package:proteam_app/core/services/main_injection_container.dart' as di;

class SearchFoodPage extends StatefulWidget {
  const SearchFoodPage({super.key});

  @override
  State<SearchFoodPage> createState() => _SearchFoodPageState();
}

class _SearchFoodPageState extends State<SearchFoodPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Provide the search cubit directly to the search page
    return BlocProvider(
      create: (context) => di.sl<FoodSearchCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: raisinBlackColor,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              title: const Text('Select Food', style: Styles.headline1),
              backgroundColor: raisinBlackColor,
              surfaceTintColor: raisinBlackColor,
            ),
            body: Column(
              children: [
                // Header (search bar)
                Container(
                  padding: const EdgeInsets.all(10.0),
                  color: raisinBlackColor,
                  child: SearchBar(
                    controller: _searchController,
                    onSubmitted: (value) async {
                      BlocProvider.of<FoodSearchCubit>(context)
                          .searchFood(value);
                    },
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 14)),
                    hintText: 'Search for a food',
                    autoFocus: true,
                    elevation: const MaterialStatePropertyAll(0),
                    leading: const Icon(Icons.search_rounded),
                    backgroundColor: const MaterialStatePropertyAll(blackColor),
                    trailing: [
                      IconButton(
                          onPressed: _searchController.clear,
                          icon: const Icon(Icons.clear))
                    ],
                  ),
                ),

                // Body (search results)
                BlocBuilder<FoodSearchCubit, FoodSearchState>(
                  builder: (context, state) {
                    // Initial state
                    if (state is FoodSearchInitial) {
                      return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 150),
                          child: Column(
                            children: [
                              Icon(Icons.search),
                              SizedBox(height: 10),
                              Text('Search to find foods')
                            ],
                          ));
                    }

                    // Loading state
                    if (state is FoodSearchInProgress) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 150),
                        child: CircularProgressIndicator(),
                      );
                    }

                    // Food results
                    else if (state is FoodSearchSuccess) {
                      if (state.foods.isEmpty) {
                        return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 150),
                            child: Column(
                              children: [
                                Icon(FontAwesomeIcons.ghost),
                                SizedBox(height: 10),
                                Text('No foods found')
                              ],
                            ));
                      }
                      return Expanded(
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 20, bottom: 8, top: 20),
                                width: MediaQuery.of(context).size.width,
                                color: raisinBlackColor,
                                child: const Text('Search Results',
                                    style: Styles.headline2)),
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.foods.length,
                                itemBuilder: (context, index) {
                                  return FoodListTile(food: state.foods[index]);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 150),
                          child: Column(
                            children: [
                              Icon(Icons.error),
                              SizedBox(height: 10),
                              Text('Oops, an error occured')
                            ],
                          ));
                    }
                  },
                )
              ],
            ));
      }),
    );
  }
}
