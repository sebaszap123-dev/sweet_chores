import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweet_chores/src/config/router/sweet_router.gr.dart';

@RoutePage()
class HelpLayout extends StatelessWidget {
  const HelpLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        FAQRoute(),
        AboutUsRoute(),
      ],
      lazyLoad: false,
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        final start = tabsRouter.activeIndex == 0;
        final screenWidth = MediaQuery.of(context).size.width;
        final begin =
            start ? Offset(screenWidth, 0.0) : Offset(-screenWidth, 0.0);
        const end = Offset.zero;

        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = tween.animate(curvedAnimation);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
              title: Text(
            'Help center',
            style: GoogleFonts.spicyRice(color: Colors.white, fontSize: 30),
          )),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              tabsRouter.setActiveIndex(index);
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.help_outline_rounded),
                label: 'FAQ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_rounded),
                label: 'About us',
              ),
            ],
          ),
        );
      },
    );
  }
}
