import 'package:flutter/material.dart';

TextStyle styleOfTexts(double size, FontWeight weight, Color color) {
  return TextStyle(
      fontSize: size,
      fontWeight: weight,
      fontFamily: 'Urbanist',
      color: color,
      height: 1);
}

const Color primaryColor = Color.fromARGB(255, 0x0c, 0x0c, 0x0c);

ThemeData themeLight(BuildContext context) {
  return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          background: Colors.white,
          seedColor: const Color.fromARGB(255, 0x0c, 0x0c, 0x0c),
          primary: const Color.fromARGB(255, 0x0c, 0x0c, 0x0c),
          onPrimary: const Color.fromARGB(255, 0x0c, 0x0c, 0x0c),
          onBackground: const Color.fromARGB(255, 0x0c, 0x0c, 0x0c),
          onSecondary: Colors.white,
          tertiary: Colors.grey),
      textTheme: TextTheme(
        displayLarge: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            fontFamily: 'Urbanist',
            color: primaryColor,
            height: 1),
        displayMedium: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist',
            color: primaryColor,
            height: 1),
        displaySmall: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: 'Urbanist',
            color: primaryColor,
            height: 1),
        labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist',
            color: Theme.of(context).colorScheme.onSecondary,
            height: 1),
        labelMedium: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist',
            color: Color.fromARGB(255, 0x0c, 0x0c, 0x0c),
            height: 1
          ),
        labelSmall: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist',
            color: Colors.white,
            height: 1),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: Theme.of(context).textTheme.displaySmall,
        hintStyle: Theme.of(context)
            .textTheme
            .displaySmall
            ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            constraints: const BoxConstraints(maxHeight: 56, minWidth: 383),
            labelStyle: Theme.of(context).textTheme.displayMedium),
        menuStyle: MenuStyle(
          fixedSize: MaterialStateProperty.all(const Size(343, 56)),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(1))),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(

          style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(164,44)),
              textStyle: MaterialStateProperty.all(
                  Theme.of(context).textTheme.labelLarge),
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.onBackground),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )))));
}

ThemeData themeDark(BuildContext context) {
  return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Colors.white,
          onPrimary: Colors.white,
          onBackground: const Color.fromARGB(255, 0x0c, 0x0c, 0x0c),
          onSecondary: const Color.fromARGB(255, 0x0c, 0x0c, 0x0c),
          tertiary: Colors.grey,
          background: const Color.fromARGB(255, 0x0c, 0x0c, 0x0c)),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            fontFamily: 'Urbanist',
            color: Colors.white,
            height: 1),
        displayMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist',
            color: Colors.white,
            height: 1),
        displaySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: 'Urbanist',
            color: Colors.white,
            height: 1),
        labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist',
            color: Colors.white,
            height: 1),
        labelMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist',
            color: Colors.white,
            height: 1),
        labelSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist',
            color: Color.fromARGB(255, 0x0c, 0x0c, 0x0c),
            height: 1),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color.fromARGB(255, 0x1f, 0x1f, 0x1f),
        labelStyle: Theme.of(context).textTheme.displaySmall,
        hintStyle: Theme.of(context)
            .textTheme
            .displaySmall
            ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            constraints: const BoxConstraints(maxHeight: 56, minWidth: 343),
            labelStyle: Theme.of(context).textTheme.displayMedium),
        menuStyle: MenuStyle(
          backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSecondary),
          fixedSize: MaterialStateProperty.all(const Size(343, 56)),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(1))),
        ),
      ),
       elevatedButtonTheme: ElevatedButtonThemeData(

          style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(164,44)),
              textStyle: MaterialStateProperty.all(
                  Theme.of(context).textTheme.labelLarge),
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.onBackground),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )))));
}
