// import 'package:flutter/material.dart';
// import 'package:gitgossip/features/DiscoverUsers/model/discover_user_model.dart';
// import 'package:gitgossip/features/DiscoverUsers/services/discover_services.dart';
// import 'package:gitgossip/features/userProfile/models/user_model.dart';
// import 'package:gitgossip/features/DiscoverUsers/widgets/developer_card_widget.dart';

// class DiscoverScreen extends StatefulWidget {
//   const DiscoverScreen({super.key});

//   @override
//   State<DiscoverScreen> createState() => _DiscoverScreenState();
// }

// class _DiscoverScreenState extends State<DiscoverScreen> {
//   final DiscoverServices _discoverServices = DiscoverServices();

//   late Future<List<DiscoverUser>> _usersList;

//   @override
//   void initState() {
//     super.initState();
//     _usersList = _discoverServices.fetchUsersForDiscoverScreen();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: Column(
//             children: [
//               const SizedBox(height: 4),

//               Text(
//                 "Discover",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Expanded(
//                 child: FutureBuilder<List<DiscoverUser>>(
//                   future: _usersList,
//                   builder: (context, snapshot) {
//                     /// 🔄 Loading state
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     /// ❌ Error state
//                     if (snapshot.hasError) {
//                       return const Center(
//                         child: Text(
//                           "Something went wrong",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       );
//                     }

//                     final users = snapshot.data ?? [];

//                     /// 📭 Empty state
//                     if (users.isEmpty) {
//                       return _buildEmptyState();
//                     }

//                     /// ✅ Success state
//                     return ListView.builder(
//                       padding: const EdgeInsets.only(bottom: 80),
//                       itemCount: users.length,
//                       itemBuilder: (context, index) {
//                         final user = users[index];

//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 12),
//                           child: DeveloperCard(user: user),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.people_outline, color: Colors.white30, size: 60),
//           SizedBox(height: 16),

//           Text(
//             "No users found",
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),

//           SizedBox(height: 8),

//           Text(
//             "Users will appear here once available",
//             style: TextStyle(color: Colors.white38, fontSize: 13),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:gitgossip/features/DiscoverUsers/model/discover_user_model.dart';
import 'package:gitgossip/features/DiscoverUsers/services/discover_services.dart';
import 'package:gitgossip/features/DiscoverUsers/widgets/developer_card_widget.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final DiscoverServices _discoverServices = DiscoverServices();

  late Future<List<DiscoverUser>> _usersList;

  @override
  void initState() {
    super.initState();
    _usersList = _discoverServices.fetchUsersForDiscoverScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),

              const Text(
                "Discover",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: FutureBuilder<List<DiscoverUser>>(
                  future: _usersList,
                  builder: (context, snapshot) {
                    /// 🔄 Loading
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    /// ❌ Error
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "Something went wrong",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    final users = snapshot.data ?? [];

                    /// 📭 Empty
                    if (users.isEmpty) {
                      return _buildEmptyState();
                    }

                    /// ✅ Success
                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: DeveloperCard(user: user),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, color: Colors.white30, size: 60),
          SizedBox(height: 16),
          Text(
            "No users found",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Users will appear here once available",
            style: TextStyle(color: Colors.white38, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
