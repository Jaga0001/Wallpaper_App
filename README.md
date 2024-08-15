# Wallpaper App 📱🎨

A simple and elegant wallpaper app built using Flutter and powered by the Pexels API. The app allows users to browse and download high-quality wallpapers from various categories.

## Features ✨

- Browse beautiful wallpapers fetched from the Pexels API.
- Display wallpapers in a grid view.
- View images by category.
- Download and set wallpapers as your device background.
- Smooth and intuitive UI with Flutter's Material Design components.

## Screenshots 📸



## Installation 🚀

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/wallpaper-app.git
   cd wallpaper-app

2. **Install dependencies:**

   ```bash
   flutter pub get

3. **Run the app:**

   ```bash
   flutter run

## Pexels API Integration 🔗

This app uses the Pexels API to fetch high-quality wallpapers. You'll need to create a free account on Pexels and obtain an API key.

Get your Pexels API key:

 1. **Visit Pexels API.**
    Sign up or log in to your account.
    Create a new API key.
    Configure your API key:

 2. Add your API key in the lib/homepage.dart file:

    ```bash
    const String apiKey = 'YOUR_PEXELS_API_KEY';

## Project Structure 🏗️
The project is structured as follows:

    
    lib/
    │
    ├── screens/
    │   ├── home_page.dart      # Main screen displaying wallpaper grid
    │   └── category_page.dart  # Screen for displaying categories
    │   └── wallpaper_page.dart # Add the selected Image as wallpaper
    └── main.dart               # Main entry point of the app

    

## Dependencies 🧩

The following Flutter packages are used in this project:

 - `http`: For making network requests to the Pexels API.
 - `flutter_cache_manager`: For caching images locally.
 - `wallpaper_manager`: To add Imagea as Wallpaper.

To install all dependencies, run:

   
    flutter pub get

*Developed with ❤️ using Flutter*.

