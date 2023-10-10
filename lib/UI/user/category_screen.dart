import 'package:flutter/material.dart';
import 'package:servantmanagement/UI/user/userdrawerpage.dart';
import '../../Firebase/Model/servant_model.dart';
import 'User_Cart.dart';
import 'WorkerDetailsPage.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  bool _isSearching = false;
  List<String> _searchList = [];

// Define a list of icons corresponding to each job type
  final List<IconData> _jobTypeIcons = [
    Icons.cookie_outlined, // You can replace these with the desired icons
    Icons.home,
    Icons.person,
    Icons.pets,
    Icons.face
  ];

  @override
  Widget build(BuildContext context) {
    void _handleCategoryTap(String selectedCategory) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WorkerList(jobType: selectedCategory),
        ),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>CartPage(selectedWorkers: [],),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search...',
                ),
                autofocus: true,
                style: const TextStyle(fontSize: 16, letterSpacing: 1),
                onChanged: (val) {
                  // Search logic
                  _searchList = ServantModel.jobTypes
                      .where((job) =>
                          job.toLowerCase().contains(val.toLowerCase()))
                      .toList();
                  setState(() {});
                },
              )
            : const Text(
                'Search',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
        backgroundColor: const Color(0xffe76f86),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.cancel : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchList.clear();
                }
              });
            },
          ),
        ],
      ),
      drawer: const UserDrawerPage(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffe76f86),
              Color(0xffd3bde5),
            ],
          ),
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                ),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: _isSearching
                    ? _searchList.length
                    : ServantModel.jobTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  final jobType = _isSearching
                      ? _searchList[index]
                      : ServantModel
                          .jobTypes[index]; // Use either search or regular list
// Get the corresponding icon for the job type
                  final icon = _jobTypeIcons[index % _jobTypeIcons.length];
                  return Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          subtitle: Column(
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Icon(
                                icon,
                                size: 70,
                              ),
                            ],
                          ),
                          // leading: Icon(icon), // Add the icon here
                          title: Text(jobType),
                          onTap: () {
                            _handleCategoryTap(jobType);
                          },
                        ),
                      ],
                    ),
                  );
                  // return Card(
                  //   elevation: 4.0,
                  //   margin: const EdgeInsets.all(8.0),
                  //   child: ListTile(
                  //     title: Text(jobType),
                  //     onTap: () {
                  //       _handleCategoryTap(jobType);
                  //     },
                  //   ),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:servantmanagement/UI/user/userdrawerpage.dart';
// import '../../Firebase/Model/servant_model.dart';
// import 'WorkerDetailsPage.dart';
//
// class CategoriesList extends StatefulWidget {
//   const CategoriesList({Key? key}) : super(key: key);
//
//   @override
//   _CategoriesListState createState() => _CategoriesListState();
// }
//
// class _CategoriesListState extends State<CategoriesList> {
//   final bool _isSearching = false;
//   final List<String> _searchList = [];
//
//   // Define a list of icons corresponding to each job type
//   final List<IconData> _jobTypeIcons = [
//     Icons.cookie_outlined, // You can replace these with the desired icons
//     Icons.home,
//     Icons.person,
//     Icons.pets,
//     Icons.home
//
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     void _handleCategoryTap(String selectedCategory) {
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => WorkerList(jobType: selectedCategory),
//         ),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         // ... (rest of your code remains the same)
//       ),
//       drawer: const UserDrawerPage(),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xffe76f86),
//               Color(0xffd3bde5),
//             ],
//           ),
//         ),
//         child: ListView(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2, // Two items per row
//                 ),
//                 shrinkWrap: true,
//                 physics: const BouncingScrollPhysics(),
//                 itemCount: _isSearching ? _searchList.length : ServantModel.jobTypes.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final jobType = _isSearching ? _searchList[index] : ServantModel.jobTypes[index]; // Use either search or regular list
//
//                   // Get the corresponding icon for the job type
//                   final icon = _jobTypeIcons[index % _jobTypeIcons.length];
//
//                   return Card(
//                     elevation: 4.0,
//                     margin: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         ListTile(
//                           subtitle:Column(
//                             children: [
//                               const SizedBox(height: 40,),
//                               Icon(icon,size: 70,),
//                             ],
//                           ) ,
//                           // leading: Icon(icon), // Add the icon here
//                           title: Text(jobType),
//                           onTap: () {
//                             _handleCategoryTap(jobType);
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
