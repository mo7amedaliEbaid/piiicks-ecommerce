# Piiicks
Piiicks is a Flutter e-commerce app, meticulously crafted with clean architecture and powered by the efficient BLoC state management ensuring scalability, maintainability, and optimal performance. Dive into a seamless coding experience with a sleek interface and robust features designed to elevate the online shopping journey.

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
12. **Pagination:** Implement pagination for efficient loading of large sets of data, ensuring a smoother user experience.


### User Interaction
13. **Sort Products:** Options to sort products based on criteria such as price.
14. **Notifications:** Keep users informed with updates on order status and more.

### User Management
15. **Login/SignUp:** Secure user authentication for a personalized experience.
16. **Shopping Cart:** Seamless and intuitive management of selected items before purchase.
17. **User Profile:** Dedicated section for managing addresses, viewing order history, and personalizing preferences.

### Additional Features
18. **Image Caching and Loading Optimization:** Utilize the `cached_network_image` package for efficient loading and caching of network images, enhancing performance.
19. **SVG Support:** Leverage the `flutter_svg` package for supporting SVG images, providing a scalable and crisp user interface.
20. **Data Caching:** Use the `shared_preferences` package for caching small amounts of data, improving the user experience by maintaining certain states.
21. **Authentication and Secure Storage:** Implement secure user authentication with the `flutter_secure_storage` package, ensuring sensitive user data is stored securely.
22. **Stateful UI with Shimmer Effect:** Enhance the user interface by incorporating the shimmering effect using the `shimmer` package, providing a polished loading experience.
23. **Dynamic Page Indicators:** Implement dynamic page indicators using the `dots_indicator` package, providing visual cues for users when navigating through different screens.
24. **HTTP Requests and API Integration:** Leverage the `http` package for making HTTP requests and seamlessly integrate with external APIs for fetching and updating data.
25. **Network Connectivity Check:** Utilize the `internet_connection_checker` package to ensure a smooth user experience by checking and handling network connectivity.
26. **Dependency Injection:** Leverage the `get_it` package for efficient dependency injection, improving code maintainability and managing dependencies effectively.
27. **Functional Programming Principles:** Explore and implement functional programming principles from the `dartz` package, enhancing code clarity and error handling.
28. **Share Products:** Enable users to share product details using the `share_plus` package for seamless sharing on social media and other platforms.
29. **Contact Us Screen with URL Launcher:** Utilize the `url_launcher` package to open the contact us screen, allowing users to interact with external links such as emails or phone numbers.
30. **Wishlist with Get Storage:** Implement a wishlist feature using the `get_storage` package to save and retrieve products, providing users with a personalized wishlist experience.
31. **Product Sharing with Screenshot:** Allow users to share product details with a screenshot using the `screenshot` package, enhancing the sharing capabilities of your app.


## Dependencies
```yaml
environment:
  sdk: '>=3.0.5 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
      # the last versions.
  equatable:
      # Package for handling value equality without explicit overrides
  dartz:
      # Functional programming library for Dart
  shared_preferences:
      # Plugin for reading and writing key-value pairs to persistent storage
  http:
      # Package for making HTTP requests
  internet_connection_checker:
      # Library for checking internet connectivity
  flutter_bloc:
      # State management library for Flutter applications
  get_it:
      # Simple service locator for Dart and Flutter projects
  shimmer:
      # Package for adding shimmering effect to Flutter applications
  cached_network_image:
      # Library for loading and caching network images
  flutter_svg:
      # Library for rendering SVG files in Flutter applications
  dots_indicator:
      # Customizable dots indicator for PageView in Flutter
  flutter_secure_storage:
      # Secure storage plugin for Flutter
  photo_view:
      # Package for displaying images in Flutter with zooming and panning capabilities
  dotted_border:
      # Package for creating dotted borders in Flutter
  flutter_local_notifications:
      # Package for displaying local notifications in Flutter applications
  share_plus:
      # Package for sharing content on social media and more
  get_storage: 
      # Persistent storage for Flutter, allowing key-value pair storage
  screenshot:
      # Flutter plugin for taking screenshots of widgets
  path_provider:
      # Plugin for interacting with the file system, including getting the app's temporary and application support directories
  url_launcher:
      # Flutter plugin for launching URLs, emails, making phone calls, and sending SMS
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
- Terms & Conditions.
- Wishlist.
- Contact Us.

For more screen shots [Here](https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/ec474e822af055693058d0beb05a5e52411d8504/screenshots)

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
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/sorting.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/filter.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/filter1.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/0cd8e6506c789cd9bc8f4ae9248c30a34e64a914/screenshots/cart.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/signup.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/profile.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/profile1.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/b90fb5675ea83f423c3742ff949d142dd4c035ab/screenshots/logged1.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/0cd8e6506c789cd9bc8f4ae9248c30a34e64a914/screenshots/adresses.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/43ccd1a70e591ebf4ecce32916eb7d3c954d0bee/screenshots/homeexit.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/43ccd1a70e591ebf4ecce32916eb7d3c954d0bee/screenshots/checkout.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/3c2986dd16cb847ef9866cb9a861d3c6167edc41/screenshots/terms.jpg" width="170" />
   <img src="https://github.com/mo7amedaliEbaid/piiicks-ecom/blob/5384c98e8609f0ca356917582dbd49e874e976b1/screenshots/wishlist.jpg" width="170" />
</p>


### ToDo:

- Orders.
- Checkout.
- Payment.






## Demos.



https://github.com/mo7amedaliEbaid/piiicks-ecommerce/assets/131966482/f5c72899-d184-4e24-ac34-186773972c57



https://github.com/mo7amedaliEbaid/piiicks-ecommerce/assets/131966482/8b35423d-26e8-4cb9-8316-0a1240630802

https://github.com/mo7amedaliEbaid/piiicks-ecommerce/assets/131966482/e13d84e6-2acc-47de-982d-61af5cf85321

https://github.com/mo7amedaliEbaid/piiicks-ecommerce/assets/131966482/6e8e134e-39f6-45c5-8bcf-2bd7d6b4c9b5






## Getting Started
1. Clone the repository.
2. Navigate to the project directory.
3. Run `flutter pub get` to fetch the dependencies.
4. Open the project in your preferred Flutter IDE.
5. Run the app on your desired emulator or physical device.



