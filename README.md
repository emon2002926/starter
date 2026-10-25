# starter — Project Guide for AI Agents

> **For AI agents:** read this entire file before writing code in this project. It defines the architecture, where files go, which shared classes to use, and the rules every new screen must follow. When this guide and your own habits disagree, follow this guide.
>
> **For humans:** paste this file into your AI agent's context (or keep it in the repo root), then ask for features, for example: *"Following README.md, create an `orders` feature with a list screen that loads from `/orders/`."*

---

## 1. Quick Facts

| Item | Value |
| ---- | ----- |
| Framework | Flutter (Dart `^3.13.0`), Material 3 |
| Package name | `starter` → imports look like `package:starter/core/...` |
| Architecture | Feature-first folders + **GetX MVC** (Model, View, Controller, Binding) |
| State management | GetX: `.obs` values + `Obx(() => ...)` |
| Dependency injection | GetX: `Get.put`, `Get.lazyPut`, `Get.find` |
| Navigation | `AppNavigation` helper over Flutter `Navigator` (go_router is installed but **not used yet**) |
| HTTP | `ApiServices` (wraps `package:http`) |
| Local storage | `StorageService` (wraps `get_storage`) |
| Default font | Plus Jakarta Sans (via `google_fonts`), applied by `AppText` and `appTheme` |
| Design size | 393 × 852 (Figma). Scale with `context.w()`, `context.h()`, `context.sp()` |
| Brand color | `AppColors.brandBlue` = **green** `#4FAF5A` (the name is legacy) |
| App title | `Averymarsh` |

---

## 2. Golden Rules

Follow these on every task.

### MUST

1. **Put each feature in its own folder:** `lib/features/<feature_name>/` with `binding/`, `controllers/`, `views/`, and optionally `models/` and `widgets/`.
2. **Put business logic in a `GetxController`**, never in a widget. Views only render state and forward taps to the controller.
3. **Register controllers in the feature's binding** with `Get.lazyPut`, and call that binding from `AppBindings.init()` in `lib/core/bindings/app_bindings.dart`.
4. **Get controllers in views with `Get.find<XController>()`.** Do not create them with `XController()` or `Get.put` inside `build`.
5. **Make reactive state `.obs`** and wrap only the widgets that depend on it in `Obx(() => ...)`.
6. **Use `ApiServices` for every network call** (`Get.find<ApiServices>()`). Pass **relative paths** such as `'/auth/login/'`.
7. **Use `StorageService` for anything persisted** (tokens, role).
8. **Use `AppNavigation` for navigation.** Pass `context:` when navigating inside a tab so the bottom bar stays visible.
9. **Use `AppText` for all text**, and `AppButton`, `AppTextField`, and the other widgets in `lib/core/widgets/` before writing a new widget.
10. **Use `AppColors` for every color.** Pass `AppColors.ink` (main text) or `AppColors.muted` (secondary text) to `AppText`, because its default color is plain black.
11. **Size everything with the `ScreenSize` extension:** `context.w(px)` for widths, horizontal padding, and radius; `context.h(px)` for heights and vertical spacing; `context.sp(px)` for raw font and icon sizes.
12. **Dispose** `TextEditingController`s and `FocusNode`s in the controller's `onClose()`.
13. **Use `CustomSnackBar`** for user feedback, and `FormValidator` for form checks.
14. If a widget is needed by **two or more features**, put it in `lib/core/widgets/<group>/`. If only one feature uses it, put it in `lib/features/<feature>/widgets/`.

### MUST NOT

1. Do not hard-code hex colors (`Color(0xFF...)`) in features. Add a token to `AppColors` if it doesn't exist.
2. Do not use the plain `Text` widget for UI copy; use `AppText`.
3. Do not call `http` directly or build headers or tokens by hand.
4. Do not pass `AppConstant.*Endpoint` values to `ApiServices`. Those are full URLs, and `ApiServices` already prepends `baseUrl`.
5. Do not show error snackbars after an `ApiServices` call fails. `ApiServices` already shows them; just catch the exception and reset loading.
6. Do not make `core/` import from `features/`. The only exception is `AppBindings`.
7. Do not use files that are commented out (`UserController`, `UserProfile`, `CustomAppButton`, `GuestOverlay`, `MathText`) without uncommenting and fixing them first.
8. Do not add a new state-management, HTTP, or routing package; use what's already in the project.

---

## 3. Folder Structure

```text
lib/
├── main.dart                         # Entry: registers ApiServices, inits storage, AppBindings, theme, first screen
├── core/                             # Shared code. Never imports from features/ (except AppBindings)
│   ├── background/starry_background.dart
│   ├── bindings/app_bindings.dart    # Calls every feature binding at startup
│   ├── constants/
│   │   ├── app_colors.dart           # AppColors: every color token
│   │   ├── app_fonts.dart            # AppFonts: bundled font family names
│   │   ├── app_constant.dart         # AppConstant: baseUrl + full endpoint URLs (legacy)
│   │   ├── app_assert_image.dart     # AppAssertImage.instance.<asset>
│   │   ├── images.dart               # AppImages.<asset> (legacy)
│   │   └── lang_codes.dart           # kLangCodes
│   ├── routes/
│   │   ├── app_router.dart           # GoRouter (empty, unused)
│   │   └── patto_page_transitions.dart
│   ├── services/api/
│   │   ├── services/api_services.dart   # ApiServices, ApiResponse, HttpException
│   │   └── models/api_response_model.dart # ApiResponseModel<T>
│   ├── themes/themes.dart            # appTheme (global ThemeData)
│   ├── user_profile/                 # Commented-out templates
│   ├── util/
│   │   ├── app_log.dart              # AppLog (debug-only logs)
│   │   ├── app_navigation.dart       # AppNavigation
│   │   ├── dashed_border_painter.dart
│   │   ├── form_validator.dart       # FormValidator, FormFieldEntry
│   │   ├── screen_size.dart          # extension ScreenSize on BuildContext
│   │   └── storage_service.dart      # StorageService
│   └── widgets/                      # Shared UI (see section 8)
└── features/
    ├── auth/                         # Sign in, sign up, OTP, forgot/reset password
    │   ├── controllers/  di/auth_binding.dart  views/  widgets/
    ├── base/                         # Bottom-tab shell after login
    │   ├── binding/base_binding.dart  controllers/base_controller.dart  views/base_page.dart
    ├── home/views/home_view.dart     # Tab 0
    ├── projects/views/project_home.dart  # Tab 1 (also used as tab 3 placeholder)
    ├── ai_chat/views/chat_screen.dart    # Tab 2
    └── profile/views/profile_page.dart
```

**File naming:** `snake_case.dart`. One public widget or class per file. Screens end in `_screen.dart`, `_page.dart`, or `_view.dart`; controllers in `_controller.dart`; bindings in `_binding.dart`.

---

## 4. How the App Works

### Startup (`lib/main.dart`)

```text
main()
 ├─ Get.put(ApiServices(baseUrl: "baseUrl"))   ← placeholder, set the real URL
 ├─ SystemChrome style (transparent status bar, dark icons)
 ├─ await GetStorage.init()
 ├─ AppBindings.init()                          ← registers all controllers
 └─ GetMaterialApp(theme: appTheme, navigatorKey: AppNavigation.navigatorKey,
                   home: StorageService.hasToken ? BasePage() : SignInScreen())
```

### Data flow (one feature)

```text
View (StatelessWidget)
  │  Get.find<XController>()
  │  Obx(() => ...) reads .obs values
  ▼
Controller (GetxController)
  │  validates input (FormValidator)
  │  calls ApiServices.get/post/...      → backend
  │  saves tokens/flags via StorageService
  │  updates .obs values                 → Obx rebuilds the View
  ▼
ApiServices
     adds headers + Bearer token, logs (AppLog), unwraps {success, message, data}
     success → returns ApiResponse
     failure → shows CustomSnackBar.error, then throws HttpException
```

### Tab shell (`features/base`)

- `BasePage` is a `Scaffold` with `AppDrawer`, an `IndexedStack` of **4 nested `Navigator`s** (Home, Projects, Latti AI, Account), and `AppNavigationBar` at the bottom.
- `BaseController.currentIndex` (`RxInt`) is the selected tab. `onTabSelected(i)` switches tabs; double-tapping the active tab pops it to its first page.
- Open the drawer from any tab: `Get.find<BaseController>().openDrawer()`.
- To push a page **inside** a tab (bottom bar stays visible): `AppNavigation.push(Page(), context: context)`.
- To push **over** the whole shell (bottom bar hidden): `AppNavigation.push(Page())`.
- To replace a tab's screen, edit the `screens` list in `lib/features/base/views/base_page.dart` and the labels and icons in `AppNavigationBar`.

---

## 5. Recipe: Create a New Feature

Example feature `orders`. Copy these templates and rename them.

**1. Model**: `lib/features/orders/models/order.dart`

```dart
class Order {
  final int id;
  final String title;
  final String status;

  const Order({required this.id, required this.title, required this.status});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        status: json['status'] ?? '',
      );
}
```

**2. Controller**: `lib/features/orders/controllers/orders_controller.dart`

```dart
import 'package:get/get.dart';
import 'package:starter/core/services/api/services/api_services.dart';
import '../models/order.dart';

class OrdersController extends GetxController {
  final _api = Get.find<ApiServices>();

  final RxList<Order> orders = <Order>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;
    try {
      final res = await _api.get('/orders/');
      final list = res.asList ?? [];
      orders.assignAll(list.whereType<Map<String, dynamic>>().map(Order.fromJson));
    } catch (_) {
      // ApiServices already showed the error snackbar
    } finally {
      isLoading.value = false;
    }
  }
}
```

**3. Binding**: `lib/features/orders/binding/orders_binding.dart`

```dart
import 'package:get/get.dart';
import '../controllers/orders_controller.dart';

class OrdersBinding {
  static void dependencies() {
    Get.lazyPut<OrdersController>(() => OrdersController(), fenix: true);
  }
}
```

**4. Register it**: in `lib/core/bindings/app_bindings.dart`

```dart
static void init() {
  AuthBinding.authDependencies();
  BaseBinding.dependencies();
  OrdersBinding.dependencies(); // add
}
```

**5. View**: `lib/features/orders/views/orders_page.dart`

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/core/constants/app_colors.dart';
import 'package:starter/core/util/screen_size.dart';
import 'package:starter/core/widgets/feature/feature_widgets.dart';
import 'package:starter/core/widgets/text/app_text.dart';
import '../controllers/orders_controller.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrdersController>();

    return FeaturePageShell(
      child: Column(
        children: [
          const FeatureAppBar(title: 'Orders'),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.orders.isEmpty) {
                return Center(child: AppText.body('No orders yet'));
              }
              return RefreshIndicator(
                onRefresh: controller.fetchOrders,
                child: FeatureSeparatedList(
                  itemCount: controller.orders.length,
                  itemBuilder: (context, i) {
                    final order = controller.orders[i];
                    return FeatureListCard(
                      title: order.title,
                      subtitle: order.status,
                      leadingLabel: '#${order.id}',
                      leadingColor: AppColors.brandBlueSoft,
                      onTap: () {},
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
```

**6. Open it**: `AppNavigation.push(const OrdersPage(), context: context);`

> `FeaturePageShell` already wraps content in `SafeArea`. If you build a plain `Scaffold` instead, add `SafeArea` yourself.

---

## 6. Recipes: Common Tasks

### Form with validation (controller side)

```dart
final emailController = TextEditingController();
final passwordController = TextEditingController();
final emailFocus = FocusNode();
final passwordFocus = FocusNode();
final RxBool isLoading = false.obs;
final RxBool obscurePassword = true.obs;

void togglePassword() => obscurePassword.toggle();

Future<void> submit() async {
  final email = emailController.text.trim();
  final password = passwordController.text;

  final ok = FormValidator.validateAll([
    FormFieldEntry(value: email, errorMessage: 'Enter your email', focusNode: emailFocus),
    FormFieldEntry(value: password, errorMessage: 'Enter your password', focusNode: passwordFocus),
  ]);
  if (!ok) return;
  if (!FormValidator.isValidEmail(email)) {
    CustomSnackBar.warning('Enter a valid email');
    emailFocus.requestFocus();
    return;
  }

  isLoading.value = true;
  try {
    final res = await _api.post('/auth/login/', body: {'email': email, 'password': password});
    final token = res.get<String>('token');
    if (token != null) await StorageService.saveToken(token);
    AppNavigation.pushAndClear(const BasePage());
  } catch (_) {
  } finally {
    isLoading.value = false;
  }
}

@override
void onClose() {
  emailController.dispose();
  passwordController.dispose();
  emailFocus.dispose();
  passwordFocus.dispose();
  super.onClose();
}
```

### Form (view side)

```dart
AppTextField(
  label: 'Email',
  hintText: 'you@example.com',
  controller: controller.emailController,
  focusNode: controller.emailFocus,
  keyboardType: TextInputType.emailAddress,
  prefixIcon: Icons.mail_outline_rounded,
),
SizedBox(height: context.h(16)),
Obx(() => AppTextField(
  label: 'Password',
  controller: controller.passwordController,
  focusNode: controller.passwordFocus,
  obscureText: controller.obscurePassword.value,
  prefixIcon: Icons.lock_outline_rounded,
  suffixIcon: controller.obscurePassword.value
      ? Icons.visibility_outlined
      : Icons.visibility_off_outlined,
  onSuffixIconTap: controller.togglePassword,
)),
SizedBox(height: context.h(28)),
Obx(() => AppButton(
  buttonText: 'Sign In',
  isLoading: controller.isLoading.value,
  onPressed: controller.submit,
  fillColor: AppColors.brandBlue,
)),
```

### File upload

```dart
await _api.postFormData(
  '/profile/update/',
  fields: {'name': name},
  imageFile: pickedFile,       // dart:io File, optional
  imageFieldName: 'avatar',    // default 'image'
);
```

### Typed response

```dart
final res = await _api.get('/me/');
final model = ApiResponseModel<User>.fromApiResponse(res, fromJson: (d) => User.fromJson(d));
```

### Handling a specific error

```dart
try {
  await _api.post('/auth/login/', body: body);
} on HttpException catch (e) {
  if (e.statusCode == 401) { /* ... */ }
}
```

### Logout

```dart
await StorageService.logout();              // keeps language preference
AppNavigation.pushAndClear(const SignInScreen());
```

### Feedback, dialogs, sheets

```dart
CustomSnackBar.success('Saved');
CustomSnackBar.error('Something failed');
CustomSnackBar.warning('Check your input');
CustomSnackBar.info('Heads up');

showDialog(
  context: context,
  builder: (_) => AppDialog(
    title: 'Delete project?',
    description: 'This cannot be undone.',
    confirmText: 'Delete',
    onConfirm: () { Navigator.pop(context); controller.delete(); },
    onCancel: () => Navigator.pop(context),
  ),
);

SuccessDialog.show(
  context: context,
  title: 'Password changed',
  description: 'You can now sign in with your new password.',
  imageString: AppAssertImage.instance.appLogo,
);

PattoBottomSheet.show(
  context: context,
  builder: (_) => PattoBottomSheet(
    padding: EdgeInsets.all(context.w(20)),
    child: Column(mainAxisSize: MainAxisSize.min, children: [/* ... */]),
  ),
);
```

### Full-screen loading overlay

```dart
Stack(children: [
  pageContent,
  AppButton.buildLoadingOverlay(isLoading: controller.isLoading, loadingMessage: 'Saving...'),
]);
```

---

## 7. Core API Reference

### `ApiServices`: `package:starter/core/services/api/services/api_services.dart`

Registered once in `main.dart`. Get it with `Get.find<ApiServices>()`.

| Method | Signature |
| ------ | --------- |
| GET | `Future<ApiResponse> get(String endpoint, {Map<String,String>? headers})` |
| POST | `Future<ApiResponse> post(String endpoint, {Map<String,String>? headers, dynamic body})` |
| PUT | `Future<ApiResponse> put(String endpoint, {headers, body})` |
| PATCH | `Future<ApiResponse> patch(String endpoint, {headers, body})` |
| DELETE | `Future<ApiResponse> delete(String endpoint, {headers, body})` |
| Multipart | `postFormData` / `putFormData` / `patchFormData(String endpoint, {headers, required Map<String,String> fields, File? imageFile, String imageFieldName = 'image'})` |

Behavior:
- Full URL = `baseUrl + endpoint`. `body` is JSON-encoded automatically.
- Adds `Accept` and `Content-Type: application/json`, plus `Authorization: Bearer <token>` if a token is saved.
- Expects the backend shape `{ "success": bool, "message": String, "data": any }`. `message` falls back to `detail`.
- **Success** (2xx and `success != false`) → returns `ApiResponse`.
- **Failure** → shows `CustomSnackBar.error(message)` and throws `HttpException`.
- **No internet, timeout, or client error** → shows a snackbar and rethrows the original exception.

`ApiResponse` fields: `statusCode`, `isSuccess`, `message`, `data`. Helpers: `asMap`, `asList`, `get<T>('key')` (reads a key from map data).

`HttpException` fields: `message`, `statusCode`, `uri`, `body`, `status`.

### `ApiResponseModel<T>`: `package:starter/core/services/api/models/api_response_model.dart`

- `ApiResponseModel<T>.fromApiResponse(ApiResponse r, {T Function(dynamic)? fromJson})`
- `ApiResponseModel<T>.fromJson(Map json, {fromJson, statusCode})`
- `ApiResponseModel.fromList<R>(Map json, {required R Function(Map) itemFromJson})` → `ApiResponseModel<List<R>>`

### `StorageService`: `package:starter/core/util/storage_service.dart`

All members are static.

| Member | Purpose |
| ------ | ------- |
| `saveToken(String)`, `accessToken`, `hasToken` | Access token |
| `saveRefreshToken(String)`, `refreshToken` | Refresh token |
| `saveRole(String)`, `userRole` | User role (`owner`, `finance`, `pm`, `field_super`); drives `AppDrawer` menu items |
| `clearToken()` | Removes the access and refresh tokens |
| `logout()` | Erases all storage except the language key |

To store something new, add a private key constant plus a getter and a `save...` method in this class. Do not call `GetStorage()` from features.

### `AppNavigation`: `package:starter/core/util/app_navigation.dart`

| Method | Use |
| ------ | --- |
| `push<T>(Widget page, {BuildContext? context})` | Open a page. With `context` it opens inside the current tab; without it, on the root navigator. |
| `pop<T>([T? result, BuildContext? context])` | Go back |
| `pushReplacement<T, TO>(Widget page, {BuildContext? context})` | Replace the current page |
| `pushAndClear<T>(Widget page)` | Clear the whole stack (login success, logout) |
| `navigatorKey` | Root navigator key, already passed to `GetMaterialApp` |

### `FormValidator`: `package:starter/core/util/form_validator.dart`

- `validateField({required String value, required String errorMessage, FocusNode? focusNode})` → `bool`. Shows a snackbar and focuses the field if empty.
- `validateAll(List<FormFieldEntry>)` → `bool`. Stops at the first empty field.
- `isValidEmail(String)`, `isValidPassword(String, {int minLength = 8})` (also requires one uppercase letter).

### `ScreenSize` extension: `package:starter/core/util/screen_size.dart`

| Member | Meaning |
| ------ | ------- |
| `context.w(px)` | Scale by width: horizontal padding, widths, radius, square icons |
| `context.h(px)` | Scale by height: vertical padding, heights, vertical gaps |
| `context.sp(px)` | Scale a font or icon size (clamped 0.8–1.3×) |
| `context.isTabletDevice` | Shortest side ≥ 600 |
| `context.screenWidth` / `screenHeight` | Raw size |
| `context.pagePadding` | Horizontal page padding (20 on phones, 48 on tablets) |
| `context.maxContentWidth` | Width to cap content on tablets (≤ 600) |
| `context.gridColumns` | 1 on phones, 2 on tablets |
| `context.spacing4/8/12/16/24/32` | Spacing presets |
| `responsiveSize`, `responsiveFontSize`, `widthPercentage`, `heightPercentage` | **Deprecated**; use `w`/`h`/`sp` |

### `AppLog`: `package:starter/core/util/app_log.dart`

`AppLog.info(msg)`, `AppLog.request(...)`, `AppLog.response(...)`, `AppLog.error(...)`. These only print in debug builds. Use `AppLog.info` instead of `print`.

### Other `core` items

| Item | Import | Notes |
| ---- | ------ | ----- |
| `appTheme` | `core/themes/themes.dart` | Global theme. Styles Material widgets (buttons, inputs, cards, app bar, snackbars) with the brand green and Plus Jakarta Sans. |
| `AppBindings.init()` | `core/bindings/app_bindings.dart` | Add every new feature binding here. |
| `AppConstant` | `core/constants/app_constant.dart` | Holds `baseUrl` and **full** endpoint URLs. Legacy; don't feed them to `ApiServices`. |
| `AppAssertImage.instance.<name>` | `core/constants/app_assert_image.dart` | Asset paths: `appLogo`, `googleLogo`, `appleLogo`, `profile`, `backgroundImage` ... Add new asset paths here. |
| `AppImages.<name>` | `core/constants/images.dart` | Legacy asset paths; don't add new ones here. |
| `AppFonts.outfit`, `AppFonts.cormorantGaramond` | `core/constants/app_fonts.dart` | For `AppText(fontFamily: ...)`. **The font files are not in `pubspec.yaml` yet.** |
| `kLangCodes` | `core/constants/lang_codes.dart` | Supported language codes. |
| `StarryBackground` | `core/background/starry_background.dart` | Night-sky gradient with stars: `StarryBackground(child: ...)`. |
| `DashedBorderPainter` | `core/util/dashed_border_painter.dart` | `CustomPaint(painter: DashedBorderPainter(color:, strokeWidth:, dashWidth:, dashSpace:, borderRadius:))`. |
| `appRouter`, `pattoTransitionPage` | `core/routes/` | go_router setup. **Unused**; don't route through it unless asked to migrate. |

---

## 8. Shared Widgets Reference (`lib/core/widgets/`)

Check this list before creating a new widget.

### Need → widget

| I need... | Use |
| --------- | --- |
| Any text | `AppText`, `AppText.display`, `AppText.body` |
| Text input | `AppTextField` |
| Search input | `AppSearchBar` |
| Primary or secondary button | `AppButton` |
| "Continue with Google/Apple" | `SocialButton` |
| Screen background with brand gradient | `FeaturePageShell` |
| In-page header with back button | `FeatureAppBar` |
| Classic `Scaffold.appBar` | `BuildAppBar` |
| App bar inside `CustomScrollView` | `BuildSliverAppBar` |
| Big gradient banner card | `FeatureHeroCard` |
| Tappable action tile | `FeatureModeCard` |
| List of cards | `FeatureSeparatedList` + `FeatureListCard` |
| Square label chip | `FeatureBadge` |
| Small uppercase section label | `FeatureQuietLabel` |
| Round glass icon button | `FeatureIconButton` |
| Confirm/cancel dialog | `AppDialog` |
| Success dialog | `SuccessDialog.show(...)` |
| Bottom sheet | `PattoBottomSheet` |
| Paywall | `PremiumPaywallSheet.show(context)` |
| Toast/snackbar | `CustomSnackBar` |
| Full-screen loader | `AppButton.buildLoadingOverlay(...)` |
| Dashed divider | `LineDivider` |
| "— or —" divider | `TextDivider` |

### Signatures

**`AppText`**: `core/widgets/text/app_text.dart`

```dart
AppText(
  data: 'Hello',                // required
  fontSize: 16,                 // scaled with sp() when useResponsiveFontSize = true (default)
  fontWeight: FontWeight.w400,
  color: AppColors.ink,         // default is Colors.black, so always pass a color
  maxLines: 2,                  // default 20
  overflow: TextOverflow.ellipsis,
  textAlign: TextAlign.center,
  height: 1.5,
  latterSpacing: -0.5,          // note spelling: "latter"
  decoration: TextDecoration.underline,
  fontFamily: AppFonts.outfit,  // or googleFontFamily: GoogleFonts.inter
  frosted: false,               // true = blurred glass pill behind the text
  style: null,                  // full override
)
AppText.display('Title', size: 28, weight: FontWeight.w800, color: AppColors.ink)  // headings
AppText.body('Body', size: 13, weight: FontWeight.w500, color: AppColors.muted)    // secondary text
```

**`AppButton`**: `core/widgets/buttons/app_button.dart`

```dart
AppButton(
  buttonText: 'Continue',       // required
  onPressed: () {},             // required; null disables the button
  isLoading: false,             // shows a spinner and disables the button
  loadingText: null,
  fillColor: AppColors.brandBlue, // default is AppColors.buttonFillColor (#2563EB blue)
  textColor: AppColors.white,
  borderColor: null, borderWidth: null,
  borderRadius: 16,             // default 16
  buttonHeight: 52,             // default 52
  buttonWidth: null,            // default full width
  fontSize: 15, fontWeight: FontWeight.w600,
  prefixIcon: null, suffixIcon: null,
  elevation: 0,
)
// Secondary or outlined: fillColor: Colors.transparent, borderColor: AppColors.uiBorder, borderWidth: 1, textColor: AppColors.ink
```

**`AppTextField`**: `core/widgets/text/text_field/AppTextFiled.dart` (the file name has a typo; import it as is)

```dart
AppTextField(
  label: 'Email', label2: 'Forgot?', label2OnClick: () {},  // label2 = link on the right of the label
  hintText: '...',
  controller: ..., focusNode: ...,
  keyboardType: TextInputType.emailAddress,
  obscureText: false,
  prefixIcon: Icons.mail_outline, suffixIcon: Icons.visibility, onSuffixIconTap: () {},
  suffixWidget: null,
  validator: null, enabled: true,
  fillColor: ..., borderColor: ..., focusedErrorBorderColor: ...,
  inputTextColor: ..., hintTextColor: ...,
  customBorderRadius: null, elevation: 0,
)
```

**`AppSearchBar`**: `core/widgets/app_search_bar.dart`
`AppSearchBar(hintText: 'Search', controller: ..., onChanged: (q) {}, margin: ..., backgroundColor: Colors.white, showBorder: true)`

**`SocialButton`**: `core/widgets/buttons/social_login_buttons.dart`
`SocialButton(onTap: ..., text: 'Continue with Google', height: context.h(52), iconPath: AppAssertImage.instance.googleLogo /* or icon: */, backgroundColor:, textColor:, borderColor:, iconColor:)`

**Feature kit**: import all at once from `core/widgets/feature/feature_widgets.dart`

```dart
FeaturePageShell(child: ..., primaryGlowColor: AppColors.brandBlue, secondaryGlowColor: AppColors.practiceTeal)
FeatureAppBar(title: 'Title', centerTitle: true, trailing: Widget?, onBack: VoidCallback?)  // default back = AppNavigation.pop
FeatureIconButton(icon: Icons.add, onTap: () {})
FeatureQuietLabel('Section')
FeatureHeroCard(title: '...', subtitle: '...', badgeLabel: 'AB', gradient: AppColors.heroGradient, shadowColor: null)
FeatureModeCard(icon: Icons.bolt, title: '...', subtitle: '...',
                gradient: AppColors.brandBlueGradient, softFill: AppColors.brandBlueSoft, onTap: () {})
FeatureSeparatedList(itemCount: n, itemBuilder: (ctx, i) => ..., header: Widget?, footer: Widget?,
                     padding: null, separatorHeight: null)
FeatureListCard(title: '...', subtitle: '...', subtitleColor:, leadingLabel: 'AB', leadingColor:,
                leading: Widget?, selected: false, showChevron: true, onTap:, onLongPress:)
// progress / progressLabel exist as parameters but are NOT rendered yet
FeatureBadge(label: 'AB', color: AppColors.brandBlueSoft, foregroundColor: AppColors.ink)
```

**App bars**
- `BuildAppBar(title:, showBackButton: true, onBackButtonPressed:, showNotification: false, onNotificationPressed:, avatarUrl:, isAssetAvatar: true, onAvatarPressed:, backgroundColor: /* default black */, titleFontSize:, fontWeight:)`. It implements `PreferredSizeWidget`, so it can be used as `Scaffold.appBar`.
- `BuildSliverAppBar(title:, showBackButton: false, showProfileIcon: true, profileImage:, onProfileTap:)`

**Dialogs and sheets**
- `AppDialog(title:, description:, confirmText:, cancelText:, required onConfirm, required onCancel)`. The confirm button is red (destructive). **It does not close itself**, so call `Navigator.pop(context)` in the callbacks.
- `SuccessDialog.show(context:, title:, description:, imageString:, buttonText: 'Continue', onPressed:)`. It closes itself if `onPressed` is null.
- `PattoBottomSheet.show(context:, builder:)` + `PattoBottomSheet(child:, padding:, backgroundColor: /* default AppColors.cream */, showHandle: true)`
- `PremiumPaywallSheet.show(context)`. Note: the class lives in `core/widgets/Drawer/app_drawer.dart`.

**Navigation widgets**
- `AppNavigationBar(currentIndex:, onTabSelected:)`. Tab icons and labels are static lists inside the file.
- `AppDrawer()`. Lives in `core/widgets/app_drawer.dart`; menu items depend on `StorageService.userRole`.

**Dividers**
- `LineDivider(lineColor: AppColors.dividerDefault, dashWidth: 4, dashSpace: 4, strokeWidth: 1)`
- `TextDivider(text: 'or', lineColor:, textColor:, fontSize: 14)`

---

## 9. Design Tokens

### Colors (`AppColors`), preferred tokens for new UI

| Role | Token |
| ---- | ----- |
| Primary / brand (green `#4FAF5A`) | `brandBlue` |
| Primary dark | `brandBlueDeep` |
| Primary soft background | `brandBlueSoft`, `brandBlueSoftAlt`, `brandBlueMist` |
| Secondary (teal) | `practiceTeal`, `practiceTealDeep`, `practiceTealSoft` |
| Main text | `ink` |
| Secondary text | `muted` |
| Screen background | `screenBgTop` → `screenBgBottom` (gradient) |
| Card / surface | `white` |
| Border | `uiBorder` |
| Success / warning / danger | `success`, `warning`, `danger` / `dangerBright` |
| Status tints | `successBackground`, `warningBackground`, `dangerBackground` |
| Accent | `liveAccent` |
| Gradients (List<Color>) | `heroGradient`, `brandBlueGradient`, `practiceTealGradient` |
| Palettes for chips/categories | `categoryTints`, `subjectBadgeColors` |

Tokens under the "legacy" comments in `app_colors.dart` (`primary50..900`, `blue2_*`, `green*`, `dark*`, `white50..900`, auth colors) exist for older screens. Prefer the tokens above for new UI.

### Typography

| Use | Code |
| --- | ---- |
| Screen title | `AppText.display('Title', size: 24)` |
| Section title | `AppText(data: ..., fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.ink)` |
| Body | `AppText(data: ..., fontSize: 14, color: AppColors.ink)` |
| Secondary / caption | `AppText.body('...')` (13, w500, muted) |
| Small label | `FeatureQuietLabel('LABEL')` |

### Spacing and shape

- Page horizontal padding: `context.pagePadding` (or `context.w(20)`).
- Vertical gaps: `SizedBox(height: context.h(8 | 12 | 16 | 24 | 32))`.
- Radius: inputs 10, buttons 16, cards 16–20, hero cards 28, bottom sheets 24 (top). Always wrap in `context.w(...)`.
- Card style: `AppColors.white` fill, `AppColors.uiBorder` border, soft shadow `Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: Offset(0, 4)`.
- Use `withValues(alpha: x)`, not the deprecated `withOpacity(x)`.

---

## 10. Known Quirks

| Quirk | What to do |
| ----- | ---------- |
| `ApiServices(baseUrl: "baseUrl")` in `main.dart` is a placeholder | Set the real API base URL before testing network code. |
| `AppColors.brandBlue*` tokens are green | The names are legacy. Use them as the brand color. |
| `AppButton` default fill is blue `#2563EB` | Pass `fillColor: AppColors.brandBlue` for brand-colored buttons, unless the screen already uses the blue (auth screens do). |
| `AppText` default color is black | Always pass `color:`. |
| `AppConstant` endpoints are full URLs | Don't pass them to `ApiServices`; use relative paths. |
| `AppNavigation.push` without `context` uses the root navigator | Pass `context:` to keep the bottom bar visible. |
| Typos in paths: `AppTextFiled.dart`, `snakbar/`, `AppAssertImage`, `latterSpacing` | Keep them as is; renaming breaks imports. |
| Two dialog files: `widgets/app_dialog.dart` (`SuccessDialog`) and `widgets/dialog/app_dialog.dart` (`AppDialog`) | Import the one that has the class you need. |
| Two drawer files: `widgets/app_drawer.dart` (`AppDrawer`) and `widgets/Drawer/app_drawer.dart` (`PremiumPaywallSheet`) | Same as above. |
| `SignInController.onSubmitTap` skips validation and the API call (commented out) and goes straight to `BasePage` | Demo behavior; re-enable the commented code when the backend is ready. |
| `FeatureListCard` has `progress` / `progressLabel` parameters that are not drawn | Implement them in the widget first if a progress bar is needed. |
| `HomeView`, `ProjectHome`, `ChatScreen`, `ProfilePage` are placeholders | Replace them with real screens using the recipes above. |
| `pubspec.yaml` declares no `assets:` or `fonts:` | Add asset folders and fonts there before using `AppAssertImage` paths or `AppFonts`. |
| `go_router` is installed but unused | Keep using `AppNavigation` unless asked to migrate. |

---

## 11. Checklist Before Finishing a Task

- [ ] New code is under `lib/features/<feature>/` (or `lib/core/` if shared).
- [ ] Logic is in a `GetxController`; the view only renders and forwards events.
- [ ] The controller is registered in a binding, and the binding is called in `AppBindings.init()`.
- [ ] Network calls use `ApiServices` with relative paths; loading resets in `finally`.
- [ ] Text uses `AppText`, colors use `AppColors`, sizes use `context.w/h/sp`.
- [ ] Existing shared widgets were reused where possible.
- [ ] `TextEditingController`s and `FocusNode`s are disposed in `onClose()`.
- [ ] No new packages were added without asking.
- [ ] `flutter analyze` shows no new errors.

---

## 12. Getting Started (humans)

```bash
flutter pub get
# set the API URL in lib/main.dart → Get.put(ApiServices(baseUrl: "https://your-api.com/api"));
flutter run
flutter analyze
```

Tech stack: `get`, `get_storage`, `http`, `http_parser`, `google_fonts`, `flutter_screenutil`, `go_router`, `fl_chart`, `intl`, `uuid`, `dotted_border`.
