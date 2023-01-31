import 'package:e_commerce/Api/categories_type.dart';
import 'package:e_commerce/Components/custom_list_tile.dart';
import 'package:e_commerce/Pages/filtered_category.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: AppBar(
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                )),
            title: const Text("Categories"),
            actions: const [
              Icon(Icons.shopping_bag),
              SizedBox(
                width: 20,
              )
            ],
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.black,
            bottom: TabBar(
              indicatorColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              indicator: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(20)),
              tabs: const [
                SizedBox(
                    height: 60,
                    child: Tab(
                      child: Text(
                        "Woman",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(
                    height: 60,
                    child: Tab(
                      child: Text(
                        "Man",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: TabBarView(
            children: [
              ListView.builder(
                  itemCount: categoriesType.length - 1,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> FilteredCategory(category: categoriesType[index + 1]['Name'])));
                      },
                      child: CustomListTile(
                        imageUrl: categoriesType[index + 1]['Icon'],
                        title: categoriesType[index + 1]['Name'],
                      ),
                    );
                  }),
              ListView.builder(
                  itemCount: categoriesType.length - 1,
                  itemBuilder: (context, index) {
                    return CustomListTile(
                      imageUrl: categoriesType[index + 1]['Icon'],
                      title: categoriesType[index + 1]['Name'],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
