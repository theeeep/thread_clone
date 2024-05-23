import 'package:flutter/material.dart';

class AddThreadAppbar extends StatelessWidget {
  const AddThreadAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xff242424),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.close),
              ),
              const SizedBox(width: 20),
              const Text(
                "Add Thread",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Post",
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
