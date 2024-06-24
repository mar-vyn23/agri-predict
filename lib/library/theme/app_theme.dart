// /*
// * File : App Theme
// * Version : 1.0.0
// * */

// import 'package:flutter/material.dart';
// import 'package:flutx/flutx.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../../theme/theme_type.dart';
// import '../utils/Utils.dart';
// import 'custom_theme.dart';

// export 'custom_theme.dart';
// export 'navigation_theme.dart';

// class AppTheme {


//   static InputDecoration InputDecorationTheme1(
//       {bool isDense = true,
//         String label = "",
//         IconData iconData = Icons.edit,
//         String hintText = ""}) {
//     return InputDecoration(
//       hintText: hintText.isEmpty ? null : hintText,
//       isDense: isDense,
//       label: (label.isEmpty)
//           ? null
//           : Text(
//         label,
//         style: TextStyle(
//             fontWeight: FontWeight.w500,
//             fontSize: 16,
//             color: Colors.grey.shade500),
//       ),

//       /*prefixIcon: Icon(
//         iconData,
//         color: Colors.grey.shade800,
//       ),*/
//       hintStyle: TextStyle(fontSize: 15, color: Color(0xaa495057)),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(4)),
//         borderSide: BorderSide(width: 1, color: Colors.green),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(4)),
//         borderSide: BorderSide(width: 1, color: Colors.black54),
//       ),
//       disabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(4)),
//         borderSide: BorderSide(width: 1, color: Colors.black54),
//       ),
//       fillColor: Colors.grey.shade100,
//       border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(4)),
//           borderSide: BorderSide(width: 1, color: Colors.black54)),
//     );
//   }

//   static TextStyle getTextStyle(TextStyle? textStyle,
//       {int fontWeight = 500,
//         bool muted = false,
//         bool xMuted = false,
//         double letterSpacing = 0.15,
//         Color? color,
//         TextDecoration decoration = TextDecoration.none,
//         double? height,
//         double wordSpacing = 0,
//         double? fontSize}) {
//     double? finalFontSize = fontSize != null ? fontSize : textStyle!.fontSize;

//     Color? finalColor;
//     if (color == null) {
//       finalColor = xMuted
//           ? textStyle!.color!.withAlpha(160)
//           : (muted ? textStyle!.color!.withAlpha(200) : textStyle!.color);
//     } else {
//       finalColor = xMuted
//           ? color.withAlpha(160)
//           : (muted ? color.withAlpha(200) : color);
//     }

//     return GoogleFonts.ibmPlexSans(
//         fontSize: finalFontSize,
//         letterSpacing: letterSpacing,
//         color: finalColor,
//         decoration: decoration,
//         height: height,
//         wordSpacing: wordSpacing);
//   }

//   static ThemeData shoppingManagerTheme = getShoppingManagerTheme();
//   static ThemeData getShoppingManagerTheme() {
//     return createThemeM3(themeType, CustomTheme.primary );
//   }

//   static ThemeData createThemeM3(ThemeType themeType, Color seedColor) {
//     if (themeType == ThemeType.light) {
//       return lightTheme.copyWith(
//           colorScheme: ColorScheme.fromSeed(
//               seedColor: seedColor, brightness: Brightness.light));
//     }
//     return darkTheme.copyWith(
//         colorScheme: ColorScheme.fromSeed(
//             seedColor: seedColor,
//             brightness: Brightness.dark,
//             onBackground: Color(0xFFDAD9CA)));
//   }

//   static ThemeData createTheme(ColorScheme colorScheme) {
//     if (themeType != ThemeType.light) {
//       return darkTheme.copyWith(
//         colorScheme: colorScheme,
//       );
//     }
//     return lightTheme.copyWith(colorScheme: colorScheme);
//   }



//   static ThemeType themeType = ThemeType.light;
//   static TextDirection textDirection = TextDirection.ltr;

//   static CustomTheme customTheme = getCustomTheme();
//   static ThemeData theme = getTheme();

//   static ThemeData shoppingTheme = shoppingLightTheme;

//   AppTheme._();

//   static ThemeData shoppingLightTheme = createTheme(
//     ColorScheme.fromSeed(
//       seedColor: CustomTheme.primary,
//       primaryContainer: Color(0xffdafafa),
//       secondary: Color(0xfff15f5f),
//       onSecondary: Color(0xffffffff),
//       secondaryContainer: Color(0xfff8d6d6),
//       onSecondaryContainer: Color(0xff570202),
//     ),
//   );




//   static init() {
//     resetFont();
//     FxAppTheme.changeTheme(lightTheme);
//     //FxAppTheme.changeDarkTheme(darkTheme);
//   }

//   static resetFont() {
//     FxTextStyle.changeFontFamily(GoogleFonts.mulish);
//     FxTextStyle.changeDefaultFontWeight({
//       100: FontWeight.w100,
//       200: FontWeight.w200,
//       300: FontWeight.w300,
//       400: FontWeight.w300,
//       500: FontWeight.w400,
//       600: FontWeight.w500,
//       700: FontWeight.w600,
//       800: FontWeight.w700,
//       900: FontWeight.w800,
//     });
//   }

//   static ThemeData getTheme([ThemeType? themeType]) {
//     themeType = themeType ?? AppTheme.themeType;
//     if (themeType == ThemeType.light) return lightTheme;
//     return lightTheme;
//   }

//   static CustomTheme getCustomTheme([ThemeType? themeType]) {
//     themeType = themeType ?? AppTheme.themeType;
//     if (themeType == ThemeType.light) return CustomTheme.lightCustomTheme;
//     return CustomTheme.darkCustomTheme;
//   }

//   static void changeFxTheme(ThemeType themeType) {
//     if (themeType == ThemeType.light) {
//       //FxAppTheme.changeThemeType(FxAppThemeType.light);
//     } else if (themeType == ThemeType.dark) {
//       //FxAppTheme.changeThemeType(FxAppThemeType.dark);
//     }
//   }

//   /// -------------------------- Light Theme  -------------------------------------------- ///
//   static final ThemeData lightTheme = ThemeData(
//     /// Brightness
//     brightness: Brightness.light,

//     /// Primary Color
//     primaryColor: CustomTheme.primary,
//     scaffoldBackgroundColor: Color(0xffffffff),
//     canvasColor: Colors.transparent,

//     /// AppBar Theme
//     appBarTheme: AppBarTheme(
//         backgroundColor: Color(0xffffffff),
//         iconTheme: IconThemeData(color: Colors.white),
//         systemOverlayStyle: Utils.init_theme(),
//         actionsIconTheme: IconThemeData(color: Colors.white)),

//     /// Card Theme
//     cardTheme: CardTheme(color: Color(0xfff6f6f6)),

//     textTheme: TextTheme(
//       titleLarge: GoogleFonts.lato(),
//       bodyLarge: GoogleFonts.lato(),
//     ),

//     /// Floating Action Theme
//     floatingActionButtonTheme: FloatingActionButtonThemeData(
//         backgroundColor: CustomTheme.primary,
//         splashColor: Color(0xffeeeeee).withAlpha(100),
//         highlightElevation: 8,
//         elevation: 4,
//         focusColor: CustomTheme.primary,
//         hoverColor: CustomTheme.primary,
//         foregroundColor: Color(0xffeeeeee)),

//     /// Divider Theme
//     dividerTheme: DividerThemeData(color: Color(0xffe8e8e8), thickness: 1),
//     dividerColor: Color(0xffe8e8e8),

//     /// Bottom AppBar Theme
//     bottomAppBarTheme:
//         BottomAppBarTheme(color: Color(0xffeeeeee), elevation: 2),

//     /// Tab bar Theme
//     tabBarTheme: TabBarTheme(
//       unselectedLabelColor: Color(0xff495057),
//       labelColor: Color(0xff3d63ff),
//       indicatorSize: TabBarIndicatorSize.label,
//       indicator: UnderlineTabIndicator(
//         borderSide: BorderSide(color: Color(0xff3d63ff), width: 2.0),
//       ),
//     ),

//     /// CheckBox theme
//     checkboxTheme: CheckboxThemeData(
//       checkColor: MaterialStateProperty.all(Color(0xffeeeeee)),
//       fillColor: MaterialStateProperty.all(CustomTheme.primary),
//     ),

//     /// Radio theme
//     radioTheme: RadioThemeData(
//       fillColor: MaterialStateProperty.all(CustomTheme.primary),
//     ),

//     ///Switch Theme
//     switchTheme: SwitchThemeData(
//       trackColor: MaterialStateProperty.resolveWith((state) {
//         const Set<MaterialState> interactiveStates = <MaterialState>{
//           MaterialState.pressed,
//           MaterialState.hovered,
//           MaterialState.focused,
//           MaterialState.selected,
//         };
//         if (state.any(interactiveStates.contains)) {
//           return Color(0xffabb3ea);
//         }
//         return null;
//       }),
//       thumbColor: MaterialStateProperty.resolveWith((state) {
//         const Set<MaterialState> interactiveStates = <MaterialState>{
//           MaterialState.pressed,
//           MaterialState.hovered,
//           MaterialState.focused,
//           MaterialState.selected,
//         };
//         if (state.any(interactiveStates.contains)) {
//           return CustomTheme.primary;
//         }
//         return null;
//       }),
//     ),

//     /// Slider Theme
//     sliderTheme: SliderThemeData(
//       activeTrackColor: Color(0xff3d63ff),
//       inactiveTrackColor: Color(0xff3d63ff).withAlpha(140),
//       trackShape: RoundedRectSliderTrackShape(),
//       trackHeight: 4.0,
//       thumbColor: Color(0xff3d63ff),
//       thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
//       overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
//       tickMarkShape: RoundSliderTickMarkShape(),
//       inactiveTickMarkColor: Colors.red[100],
//       valueIndicatorShape: PaddleSliderValueIndicatorShape(),
//       valueIndicatorTextStyle: TextStyle(
//         color: Color(0xffeeeeee),
//       ),
//     ),

//     /// Other Colors
//     splashColor: Colors.white.withAlpha(100),
//     indicatorColor: Color(0xffeeeeee),
//     highlightColor: Color(0xffeeeeee), colorScheme: ColorScheme.light(
//         primary: CustomTheme.primary,
//         onPrimary: Color(0xffeeeeee),
//         onSecondary: Color(0xffeeeeee),
//         surface: Color(0xffeeeeee),
//         background: Color(0xffeeeeee),
//         onBackground: Color(0xff495057)).copyWith(background: Color(0xffffffff)).copyWith(error: Color(0xfff0323c)),
//   );

//   /// -------------------------- Dark Theme  -------------------------------------------- ///
//   static final ThemeData darkTheme = ThemeData(
//     /// Brightness
//     brightness: Brightness.dark,

//     /// Primary Color
//     primaryColor: Color(0xff069DEF),

//     /// Scaffold and Background color
//     scaffoldBackgroundColor: Color(0xff161616),
//     canvasColor: Colors.transparent,

//     /// AppBar Theme
//     appBarTheme: AppBarTheme(backgroundColor: Color(0xff161616)),

//     /// Card Theme
//     cardTheme: CardTheme(color: Color(0xff222327)),

//     /// Input (Text-Field) Theme
//     inputDecorationTheme: InputDecorationTheme(
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(4)),
//         borderSide: BorderSide(width: 1, color: Color(0xff069DEF)),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(4)),
//         borderSide: BorderSide(width: 1, color: Colors.white70),
//       ),
//       border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(4)),
//           borderSide: BorderSide(width: 1, color: Colors.white70)),
//     ),

//     /// Divider Color
//     dividerTheme: DividerThemeData(color: Color(0xff363636), thickness: 1),
//     dividerColor: Color(0xff363636),

//     /// Floating Action Theme
//     floatingActionButtonTheme: FloatingActionButtonThemeData(
//         backgroundColor: Color(0xff069DEF),
//         splashColor: Colors.white.withAlpha(100),
//         highlightElevation: 8,
//         elevation: 4,
//         focusColor: Color(0xff069DEF),
//         hoverColor: Color(0xff069DEF),
//         foregroundColor: Colors.white),

//     /// Bottom AppBar Theme
//     bottomAppBarTheme:
//         BottomAppBarTheme(color: Color(0xff464c52), elevation: 2),

//     /// Tab bar Theme
//     tabBarTheme: TabBarTheme(
//       unselectedLabelColor: Color(0xff495057),
//       labelColor: Color(0xff069DEF),
//       indicatorSize: TabBarIndicatorSize.label,
//       indicator: UnderlineTabIndicator(
//         borderSide: BorderSide(color: Color(0xff069DEF), width: 2.0),
//       ),
//     ),

//     ///Switch Theme
//     switchTheme: SwitchThemeData(
//       trackColor: MaterialStateProperty.resolveWith((state) {
//         const Set<MaterialState> interactiveStates = <MaterialState>{
//           MaterialState.pressed,
//           MaterialState.hovered,
//           MaterialState.focused,
//           MaterialState.selected,
//         };
//         if (state.any(interactiveStates.contains)) {
//           return Color(0xffabb3ea);
//         }
//         return null;
//       }),
//       thumbColor: MaterialStateProperty.resolveWith((state) {
//         const Set<MaterialState> interactiveStates = <MaterialState>{
//           MaterialState.pressed,
//           MaterialState.hovered,
//           MaterialState.focused,
//           MaterialState.selected,
//         };
//         if (state.any(interactiveStates.contains)) {
//           return CustomTheme.primary;
//         }
//         return null;
//       }),
//     ),

//     /// Slider Theme
//     sliderTheme: SliderThemeData(
//       activeTrackColor: Color(0xff069DEF),
//       inactiveTrackColor: Color(0xff069DEF).withAlpha(100),
//       trackShape: RoundedRectSliderTrackShape(),
//       trackHeight: 4.0,
//       thumbColor: Color(0xff069DEF),
//       thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
//       overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
//       tickMarkShape: RoundSliderTickMarkShape(),
//       inactiveTickMarkColor: Colors.red[100],
//       valueIndicatorShape: PaddleSliderValueIndicatorShape(),
//       valueIndicatorTextStyle: TextStyle(
//         color: Colors.white,
//       ),
//     ),

//     ///Other Color
//     indicatorColor: Colors.white,
//     disabledColor: Color(0xffa3a3a3),
//     highlightColor: Colors.white.withAlpha(28),
//     cardColor: Color(0xff282a2b),
//     splashColor: Colors.white.withAlpha(56), colorScheme: const ColorScheme.dark(
//       primary: Color(0xff069DEF),
//       secondary: Color(0xff069DEF),
//       background: Color(0xff161616),
//       onPrimary: Colors.white,
//       onBackground: Color(0xfff3f3f3),
//       onSecondary: Colors.white,
//       surface: Color(0xff585e63),
//     ).copyWith(background: Color(0xff161616)).copyWith(error: Colors.orange),
//   );
// }
