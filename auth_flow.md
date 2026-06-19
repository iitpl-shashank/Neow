# Authentication and Onboarding Flow Documentation

This document explains the authentication, onboarding, and session management flows of the **Neow** application. The system implements a hybrid authentication model using **Firebase Phone Auth** for SMS OTP verification and a **Custom Laravel-based Backend API** for role-based sessions and JWT access tokens.

---

## 1. Auth Flow Architecture Overview

The authentication structure comprises:
- **Firebase Auth (Client SDK)**: Sends SMS OTPs to the mobile number and validates the code to retrieve standard credentials.
- **Custom App API Service (`ApiServices`)**: Validates device tokens, manages backend user sessions, performs onboarding parameter updates, and registers/signs out users.
- **Local Storage (`AppPreferences`)**: Persists the JWT access token, FCM device token, user demographic preferences, and onboarding progress states.

```mermaid
graph TD
    UI[Flutter UI Layer] -->|1. Request OTP / Sign In| Firebase[Firebase Auth SDK]
    UI -->|2. Verify Session / Login| API[Backend Laravel API]
    API -->|3. Issue JWT Token| UI
    UI -->|4. Persist Session & Tokens| Prefs[AppPreferences Local Storage]
    API -.->|Bearer Authorization| Prefs
```

---

## 2. API Endpoints Reference

The following endpoints defined in `ApiUrl` (`lib/services/api_url.dart`) govern authentication, session security, and profile onboarding states:

| Endpoint | HTTP Method | Request Body / Params | Authorization Header | Description |
| :--- | :--- | :--- | :--- | :--- |
| `api/signup` | `POST` | `role_id`, `email`, `mobile`, `password` | None | Registers a new user. |
| `api/checkDeviceToken` | `POST` | `mobile` | None | Checks if the user's mobile number has an active session on another device. |
| `api/removeExistingDeviceToken`| `POST` | `mobile` | None | Deauthorizes current FCM device token mapped to this mobile number. |
| `api/login` | `POST` | `mobile`, `role_id`, `device_token` | None | Authenticates with the backend, records FCM token, and returns a JWT access token. |
| `api/user-details` | `GET` | None | `Bearer <JWT>` | Retrieves the current user's profile metadata and syncs local state. |
| `api/storeState` | `POST` | `state_id` | `Bearer <JWT>` | Associates the user's account with a state. |
| `api/storeCity` | `POST` | `city_id` | `Bearer <JWT>` | Associates the user's account with a city. |
| `api/user-update-details` | `POST` | `role_id`, `name`, `birthdate`, `gender`, `gender_type`, `relationship_status`, `average_cycle_length`, `previous_periods_begin`, etc. | `Bearer <JWT>` | Saves onboarding questionnaire progress and profile variables. |
| `api/logout` | `GET` | None | `Bearer <JWT>` | Invalidates user JWT token on the backend server. |
| `api/change-status` | `POST` | None | `Bearer <JWT>` | Deactivates/deletes user account. |

---

## 3. Core Walkthrough Flows

### A. Sign-In & Verification Sequence
The sign-in flow uses the user's 10-digit mobile number. The flow ensures device session management (checking for login on other devices) before sending a Firebase SMS OTP.

```mermaid
sequenceDiagram
    autonumber
    actor User as Mobile App User
    participant View as SignInView
    participant VM as SignInViewModel
    participant API as Backend API
    participant FB as Firebase Auth SDK
    participant OTPView as OTPView
    participant OTPVM as OTPViewModel

    User->>View: Enter Phone Number & Click "Continue"
    View->>VM: checkDeviceTokenApi(mobile)
    VM->>API: POST /checkDeviceToken
    API-->>VM: Return Status ("yes" or "no")
    
    alt If isDeviceStatus == "yes" (Logged in elsewhere)
        VM->>API: POST /removeExistingDeviceToken
        API-->>VM: Token removed successfully
    end

    VM->>FB: verifyPhoneNumber("+91" + mobile)
    FB-->>User: Sends SMS OTP Code
    FB-->>VM: codeSent Callback triggered (verificationId generated)
    VM->>View: Navigate to OTPView
    User->>OTPView: Input 6-Digit OTP Code
    OTPView->>OTPVM: checkOTP(code, verificationId, phone)
    OTPVM->>FB: signInWithCredential(credential)
    FB-->>OTPVM: Firebase Login Successful
    
    OTPVM->>VM: loginApi(mobile, roleId)
    VM->>API: POST /login {mobile, role_id, device_token}
    API-->>VM: Return LoginMaster (token, user details)
    VM->>VM: Save Access Token & User Details to AppPreferences
    VM->>View: Delegate to SplashViewModel Navigation checks
```

---

### B. Onboarding & Profile Setup Flow Chart
When a user logs in, the app checks if their profile metadata is complete. If incomplete, it routes them through a series of onboarding steps:

```mermaid
flowchart TD
    A[Start Login / Session Check] --> B{Are global user details complete?}
    B -- No --> C[Navigate to PrivacyPolicyView]
    B -- Yes --> D[Navigate to Dashboard / Navbar]
    
    C -->|Accept T&C| E[Navigate to StateSelectionView]
    E -->|Select State & City| F[Call storeState & storeCity APIs]
    F --> G[Navigate to WelcomeView Page 1]
    
    G -->|Enter Name| H[WelcomeView Page 2]
    H -->|Select Gender| I[WelcomeView Page 3]
    I -->|Select Relationship Status| J[WelcomeView Page 4]
    J -->|Select Birthdate| K[Age Checking Logic]
    
    K -->|Age <= 50| L[Survey Options / Vaccination]
    K -->|Age > 50| M[Ask Menstrual / Menopause status]
    
    L & M --> N{User Role}
    
    N -->|NEOWME / CYCLE_EXPLORER| O[Enter Cycle Length Details & Save]
    N -->|BUDDY| P[Enter Pairing Naveli UID Code]
    
    O --> Q[Call user-update-details API]
    P --> R[Call user-update-details & verifyUniqueId APIs]
    
    Q & R --> S[Display WelComeGifView]
    S --> T[Call login redirect]
    T --> D
```

---

### C. Splash View / App Startup Validation
When the user opens the app, the session check resolves navigation routes based on the token presence and session validity:

```mermaid
flowchart TD
    Start[Open App / Splash Screen] --> CheckLocal{Is local Access Token saved?}
    CheckLocal -- No --> SelectRole[Navigate to SelectOptionView / Login options]
    
    CheckLocal -- Yes --> SyncDetails[Call api/user-details with Bearer token]
    SyncDetails --> CheckSuccess{API Success?}
    
    CheckSuccess -- No / Expired --> ClearPrefs[Clear Preferences / Clear token]
    ClearPrefs --> SelectRole
    
    CheckSuccess -- Yes --> UpdatePrefs[Save User details in AppPreferences]
    UpdatePrefs --> CheckComplete{Details complete?}
    
    CheckComplete -- No --> PrivacyPolicy[Navigate to PrivacyPolicyView]
    CheckComplete -- Yes --> Dash[Navigate directly to BottomNavbarView]
```

---

## 4. Technical Implementation Notes

### Access Token Injection
Authenticated endpoints use `AppBaseClient.postApiWithTokenCall()` or `AppBaseClient.getApiWithTokenCall()`. The access token is injected dynamically:
```dart
String accessToken = AppPreferences.instance.getAccessToken();
// Injected into HTTP request header:
headers: {
  "Content-Type": "application/json",
  "Authorization": "Bearer $accessToken",
}
```

### Logout and Local Cleanup
When a user logs out (`logoutApi` in `SplashViewModel`), the app issues a request to the backend `/logout` endpoint to invalidate the session token on the server. Following this, the application executes `clearPreference()`, which clears all cached states while retaining the base language code and device push token:
```dart
Future<void> clearPreference() async {
  mainNavKey.currentContext!.read<BottomNavbarViewModel>().selectedIndex = 0;
  String fCMToken = AppPreferences.instance.getFCMToken();
  String langCode = AppPreferences.instance.getLanguageCode();
  await AppPreferences.instance.clear();
  await AppPreferences.instance.setIsFirstTime(false);
  await AppPreferences.instance.setLanguageCode(langCode);
  await AppPreferences.instance.setFCMToken(fCMToken);
  globalUserMaster = null;
  gUserType = "";
  pushAndRemoveUntil(const SelectOptionView());
}
```
