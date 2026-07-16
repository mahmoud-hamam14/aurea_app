// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `AUREA`
  String get appTitle {
    return Intl.message('AUREA', name: 'appTitle', desc: '', args: []);
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to continue your luxury shopping experience.`
  String get signinSubtitle {
    return Intl.message(
      'Sign in to continue your luxury shopping experience.',
      name: 'signinSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `LOGIN`
  String get login {
    return Intl.message('LOGIN', name: 'login', desc: '', args: []);
  }

  /// `Forget Password?`
  String get forgotPassword {
    return Intl.message(
      'Forget Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message('Sign Up', name: 'signup', desc: '', args: []);
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Join the world of exquisite craftsmanship`
  String get joinSubtitle {
    return Intl.message(
      'Join the world of exquisite craftsmanship',
      name: 'joinSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message('First Name', name: 'firstName', desc: '', args: []);
  }

  /// `Last Name`
  String get lastName {
    return Intl.message('Last Name', name: 'lastName', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `OR CONTINUE WITH`
  String get orContinueWith {
    return Intl.message(
      'OR CONTINUE WITH',
      name: 'orContinueWith',
      desc: '',
      args: [],
    );
  }

  /// `OR SIGN UP WITH`
  String get orSignUpWith {
    return Intl.message(
      'OR SIGN UP WITH',
      name: 'orSignUpWith',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get explore {
    return Intl.message('Explore', name: 'explore', desc: '', args: []);
  }

  /// `Collections`
  String get collections {
    return Intl.message('Collections', name: 'collections', desc: '', args: []);
  }

  /// `All Products`
  String get allProducts {
    return Intl.message(
      'All Products',
      name: 'allProducts',
      desc: '',
      args: [],
    );
  }

  /// `Search our archives...`
  String get searchArchives {
    return Intl.message(
      'Search our archives...',
      name: 'searchArchives',
      desc: '',
      args: [],
    );
  }

  /// `INVENTORY`
  String get inventory {
    return Intl.message('INVENTORY', name: 'inventory', desc: '', args: []);
  }

  /// `Admin Panel`
  String get adminPanel {
    return Intl.message('Admin Panel', name: 'adminPanel', desc: '', args: []);
  }

  /// `Save Product`
  String get saveProduct {
    return Intl.message(
      'Save Product',
      name: 'saveProduct',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get addProduct {
    return Intl.message('Add Product', name: 'addProduct', desc: '', args: []);
  }

  /// `Product Name`
  String get productName {
    return Intl.message(
      'Product Name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Stock`
  String get stock {
    return Intl.message('Stock', name: 'stock', desc: '', args: []);
  }

  /// `Color`
  String get color {
    return Intl.message('Color', name: 'color', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Product Name (Arabic)`
  String get arabicName {
    return Intl.message(
      'Product Name (Arabic)',
      name: 'arabicName',
      desc: '',
      args: [],
    );
  }

  /// `Description (Arabic)`
  String get arabicDescription {
    return Intl.message(
      'Description (Arabic)',
      name: 'arabicDescription',
      desc: '',
      args: [],
    );
  }

  /// `Material`
  String get material {
    return Intl.message('Material', name: 'material', desc: '', args: []);
  }

  /// `Weight`
  String get weight {
    return Intl.message('Weight', name: 'weight', desc: '', args: []);
  }

  /// `Availability`
  String get availability {
    return Intl.message(
      'Availability',
      name: 'availability',
      desc: '',
      args: [],
    );
  }

  /// `In Stock`
  String get inStock {
    return Intl.message('In Stock', name: 'inStock', desc: '', args: []);
  }

  /// `Out of Stock`
  String get outOfStock {
    return Intl.message('Out of Stock', name: 'outOfStock', desc: '', args: []);
  }

  /// `Buy Now`
  String get buyNow {
    return Intl.message('Buy Now', name: 'buyNow', desc: '', args: []);
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message('Add to Cart', name: 'addToCart', desc: '', args: []);
  }

  /// `Related Products`
  String get relatedProducts {
    return Intl.message(
      'Related Products',
      name: 'relatedProducts',
      desc: '',
      args: [],
    );
  }

  /// `Customer Reviews`
  String get customerReviews {
    return Intl.message(
      'Customer Reviews',
      name: 'customerReviews',
      desc: '',
      args: [],
    );
  }

  /// `YOUR SHOPPING BAG`
  String get yourShoppingBag {
    return Intl.message(
      'YOUR SHOPPING BAG',
      name: 'yourShoppingBag',
      desc: '',
      args: [],
    );
  }

  /// `YOUR SHOPPING BAG IS EMPTY`
  String get emptyBag {
    return Intl.message(
      'YOUR SHOPPING BAG IS EMPTY',
      name: 'emptyBag',
      desc: '',
      args: [],
    );
  }

  /// `Refresh Bag`
  String get refreshBag {
    return Intl.message('Refresh Bag', name: 'refreshBag', desc: '', args: []);
  }

  /// `Order Summary`
  String get orderSummary {
    return Intl.message(
      'Order Summary',
      name: 'orderSummary',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `ACCOUNT SETTINGS`
  String get accountSettings {
    return Intl.message(
      'ACCOUNT SETTINGS',
      name: 'accountSettings',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `SUPPORT & LEGAL`
  String get supportLegal {
    return Intl.message(
      'SUPPORT & LEGAL',
      name: 'supportLegal',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message('About Us', name: 'aboutUs', desc: '', args: []);
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message('Subtotal', name: 'subtotal', desc: '', args: []);
  }

  /// `Shipping`
  String get shipping {
    return Intl.message('Shipping', name: 'shipping', desc: '', args: []);
  }

  /// `Seasonal Offer`
  String get seasonalOffer {
    return Intl.message(
      'Seasonal Offer',
      name: 'seasonalOffer',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `PROCEED TO CHECKOUT`
  String get proceedToCheckout {
    return Intl.message(
      'PROCEED TO CHECKOUT',
      name: 'proceedToCheckout',
      desc: '',
      args: [],
    );
  }

  /// `FREE`
  String get free {
    return Intl.message('FREE', name: 'free', desc: '', args: []);
  }

  /// `INITIALIZING EXPERIENCE`
  String get initializingExperience {
    return Intl.message(
      'INITIALIZING EXPERIENCE',
      name: 'initializingExperience',
      desc: '',
      args: [],
    );
  }

  /// `FINE JEWELRY & ARTISTRY`
  String get fineJewelryArtistry {
    return Intl.message(
      'FINE JEWELRY & ARTISTRY',
      name: 'fineJewelryArtistry',
      desc: '',
      args: [],
    );
  }

  /// `Discover Luxury Accessories`
  String get discoverLuxury {
    return Intl.message(
      'Discover Luxury Accessories',
      name: 'discoverLuxury',
      desc: '',
      args: [],
    );
  }

  /// `Curated collections of the world's finest jewelry and accessories.`
  String get curatedCollections {
    return Intl.message(
      'Curated collections of the world\'s finest jewelry and accessories.',
      name: 'curatedCollections',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `Only {count} items in stock`
  String itemsInStock(Object count) {
    return Intl.message(
      'Only $count items in stock',
      name: 'itemsInStock',
      desc: '',
      args: [count],
    );
  }

  /// `Added {name} to cart`
  String addedToCart(Object name) {
    return Intl.message(
      'Added $name to cart',
      name: 'addedToCart',
      desc: '',
      args: [name],
    );
  }

  /// `Welcome back`
  String get welcomeBackMsg {
    return Intl.message(
      'Welcome back',
      name: 'welcomeBackMsg',
      desc: '',
      args: [],
    );
  }

  /// `Deleting {name}...`
  String deletingProduct(Object name) {
    return Intl.message(
      'Deleting $name...',
      name: 'deletingProduct',
      desc: '',
      args: [name],
    );
  }

  /// `Search products...`
  String get searchProducts {
    return Intl.message(
      'Search products...',
      name: 'searchProducts',
      desc: '',
      args: [],
    );
  }

  /// `No products found`
  String get noProductsFound {
    return Intl.message(
      'No products found',
      name: 'noProductsFound',
      desc: '',
      args: [],
    );
  }

  /// `Product added successfully!`
  String get productAdded {
    return Intl.message(
      'Product added successfully!',
      name: 'productAdded',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
