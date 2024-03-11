import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 0,
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.black12,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Notificações', 
                              style: TextStyle(fontSize: 18, color: Colors.orangeAccent.shade400)),
                              const SizedBox(width: 20),
                              Icon(Icons.message, color: Colors.orangeAccent.shade400),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return SizedBox(
                    height: 30,
                    child: ListTile(
                      title: Text('Notificação $index', 
                      style: const TextStyle(fontSize: 13, color: Colors.white)),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  );
                }),
                separatorBuilder: (_, __) => const Divider(),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}