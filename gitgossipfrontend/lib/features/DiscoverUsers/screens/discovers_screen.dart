import 'package:flutter/material.dart';
import 'package:gitgossip/features/DiscoverUsers/models/discover_user_mdoel.dart';
import 'package:gitgossip/features/DiscoverUsers/widgets/developer_card_widget.dart';
import 'package:gitgossip/features/DiscoverUsers/widgets/seacrh_bar_widget.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarWidget(),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: developers.length,
                  itemBuilder: (context, index) {
                    final developer = developers[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: DeveloperCard(developer: developer),
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
}
