# Piiicks
Welcome to my Flutter Piiicks e-commerce app, meticulously crafted with clean architecture and powered by the efficient BLoC state management ensuring scalability, maintainability, and optimal performance. Dive into a seamless coding experience with a sleek interface and robust features designed to elevate the online shopping journey.

## Directory Structure.
- **lib**
  - **main.dart:** Entry point of the application.
  - **📂application ──📂blocs/cubits:** Houses the BLoC (Business Logic Component) or Cubit classes responsible for managing the application's state.
  - **📂core:** Contains core functionalities and utilities shared across the application.
  - **📂configs:** Holds configuration files for the project.
  - **📂di:** Dependency Injection setup for managing dependencies and services.
  - **📂data:** Manages data sources, repositories, and data models.
  - **📂domain:** Defines the domain entities, use cases, and interfaces.
  - **📂presentation ──📂screens/widgets:** Contains UI components, screens, and widgets for the application.


## Features
1. **Clean Architecture:** Ensure a modular and scalable architecture for long-term maintainability.
2. **BLoC State Management:** Efficient state management for a smooth and predictable user experience.

### User Interface
3. **Product Screen:** User-friendly display of products for effortless browsing.
4. **Categories:** Seamless navigation through various product categories.
5. **Product Details:** In-depth information for a comprehensive view of products.
6. **Search Functionality:** Robust search feature for quick product discovery.
7. **Search Results:** Clear and relevant search results for user convenience.
8. **Home Screen:** Engaging showcase of featured products and categories.
9. **Filter Options:** Intuitive product filtering options for a customized shopping experience.
10. **Splash Screen:** Captivating initial loading screen setting the tone for the app.
11. **Addresses:** Effortlessly manage and edit user addresses for smooth order processing.

### User Interaction
12. **Sort Products:** Options to sort products based on criteria such as price, popularity, or relevance.
13. **Notifications:** Keep users informed with updates on order status, promotions, and more.

### User Management
14. **Login/SignUp:** Secure user authentication for a personalized experience.
15. **Shopping Cart:** Seamless and intuitive management of selected items before purchase.
16. **User Profile:** Dedicated section for managing addresses, viewing order history, and personalizing preferences.

### Additional Features
17. **Image Caching and Loading Optimization:** Utilize the `cached_network_image` package for efficient loading and caching of network images, enhancing performance.
18. **SVG Support:** Leverage the `flutter_svg` package for supporting SVG images, providing a scalable and crisp user interface.
19. **Data Caching:** Use the `shared_preferences` package for caching small amounts of data, improving the user experience by maintaining certain states.
20. **Authentication and Secure Storage:** Implement secure user authentication with the `flutter_secure_storage` package, ensuring sensitive user data is stored securely.
21. **Stateful UI with Shimmer Effect:** Enhance the user interface by incorporating the shimmering effect using the `shimmer` package, providing a polished loading experience.
22. **Dynamic Page Indicators:** Implement dynamic page indicators using the `dots_indicator` package, providing visual cues for users when navigating through different screens.
23. **HTTP Requests and API Integration:** Leverage the `http` package for making HTTP requests and seamlessly integrate with external APIs for fetching and updating data.
24. **Network Connectivity Check:** Utilize the `internet_connection_checker` package to ensure a smooth user experience by checking and handling network connectivity.
25. **Dependency Injection:** Leverage the `get_it` package for efficient dependency injection, improving code maintainability and managing dependencies effectively.
26. **Functional Programming Principles:** Explore and implement functional programming principles from the `dartz` package, enhancing code clarity and error handling.

## Getting Started
1. Clone the repository.
2. Navigate to the project directory.
3. Run `flutter pub get` to fetch the dependencies.
4. Open the project in your preferred Flutter IDE.
5. Run the app on your desired emulator or physical device.

## Dependencies
```yaml
environment:
  sdk: '>=3.0.5 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
 # the last versions.
  equatable: # Package for handling value equality without explicit overrides
  dartz:  # Functional programming library for Dart
  shared_preferences: # Plugin for reading and writing key-value pairs to persistent storage
  http: # Package for making HTTP requests
  internet_connection_checker: # Library for checking internet connectivity
  flutter_bloc: # State management library for Flutter applications
  get_it: # Simple service locator for Dart and Flutter projects
  shimmer:  # Package for adding shimmering effect to Flutter applications
  cached_network_image:  # Library for loading and caching network images
  flutter_svg: # Library for rendering SVG files in Flutter applications
  dots_indicator: # Customizable dots indicator for PageView in Flutter
  flutter_secure_storage: # Secure storage plugin for Flutter
  photo_view: # Package for displaying images in Flutter with zooming and panning capabilities
  dotted_border: # Package for creating dotted borders in Flutter
  flutter_local_notifications: # Package for displaying local notifications in Flutter applications
```


## Screens.
### Done:
- Products.
- Categories.
- Product Details.
- Search.
- Search Result.
- Home.
- Filter.
- Login.
- SignUp.
- Splash.
- Cart.
- Profile.
- Adresses.
- Add/Edit Adress.
- Sort Products.
- Notifications.
  
<p float="left">
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/8e5f750515f9eddb7e26e90001ba9dfa1167bbd6/screenshots/allproducts.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/8e5f750515f9eddb7e26e90001ba9dfa1167bbd6/screenshots/categories.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/8e5f750515f9eddb7e26e90001ba9dfa1167bbd6/screenshots/details.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/8e5f750515f9eddb7e26e90001ba9dfa1167bbd6/screenshots/details1.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/8e5f750515f9eddb7e26e90001ba9dfa1167bbd6/screenshots/details_photoview.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/splash.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/home3.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/home2.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/0cd8e6506c789cd9bc8f4ae9248c30a34e64a914/screenshots/addadress.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/searchresult.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/search_noresult.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/sorting.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/filter.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/filter1.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/0cd8e6506c789cd9bc8f4ae9248c30a34e64a914/screenshots/cart.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/signup.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/profile.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/profile1.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/logged1.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/0cd8e6506c789cd9bc8f4ae9248c30a34e64a914/screenshots/adresses.jpg" width="170" />
</p>


### ToDo:

- Orders.
- Checkout.
- Payment.






## Demos.
https://github.com/mo7amedaliEbaid/piiicks-ecommerce/assets/131966482/8b35423d-26e8-4cb9-8316-0a1240630802

https://github.com/mo7amedaliEbaid/piiicks-ecommerce/assets/131966482/e13d84e6-2acc-47de-982d-61af5cf85321

https://github.com/mo7amedaliEbaid/piiicks-ecommerce/assets/131966482/6e8e134e-39f6-45c5-8bcf-2bd7d6b4c9b5










