import 'package:auto_route/annotations.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sweet_chores/src/core/utils/sweet_chores_dialogs.dart';

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

final List<FAQItem> faqs = [
  FAQItem(
    question: 'What is this app about?',
    answer: 'This app helps users manage their tasks efficiently.',
  ),
  FAQItem(
    question: 'How can I add a new task?',
    answer: 'You can add a new task by tapping on the "+" button.',
  ),
  FAQItem(
    question: 'Can I customize the categories?',
    answer: 'Yes, you can manage your categories in the settings.',
  ),
];

@RoutePage()
class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SalutationWidget(),
            const SizedBox(height: 20),
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: FAQWidget(faq: faqs[index]),
                );
              },
            ),
            const SizedBox(height: 20),
            const ContactUsWidget(),
          ],
        ),
      ),
    );
  }
}

class SalutationWidget extends StatelessWidget {
  const SalutationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.waving_hand_rounded, color: Colors.yellow, size: 40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Hello, how can we help you today?',
                style: TextStyle(fontSize: 28),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FAQWidget extends StatelessWidget {
  final FAQItem faq;

  const FAQWidget({super.key, required this.faq});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 10),
        child: ExpandablePanel(
          header: Text(
            faq.question,
            style: const TextStyle(fontSize: 18),
          ),
          collapsed: Container(),
          expanded: Text(
            faq.answer,
            softWrap: true,
          ),
        ),
      ),
    );
  }
}

class ContactUsWidget extends StatelessWidget {
  const ContactUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Contact Us',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // IconButton(
            //   icon: const Icon(
            //     FontAwesomeIcons.whatsapp,
            //     color: Colors.green,
            //     size: 45,
            //   ),
            //   onPressed: () {
            //     // TODO: Handle WhatsApp contact
            //   },
            // ),
            // IconButton(
            //   icon: const Icon(
            //     FontAwesomeIcons.telegram,
            //     color: Colors.blue,
            //     size: 45,
            //   ),
            //   onPressed: () {
            //     // TODO: Handle Telegram contact
            //   },
            // ),
            IconButton(
              icon: Icon(
                Icons.email,
                color: Theme.of(context).colorScheme.secondary,
                size: 45,
              ),
              onPressed: SweetDialogs.sendSupportEmail,
            ),
          ],
        ),
      ],
    );
  }
}
