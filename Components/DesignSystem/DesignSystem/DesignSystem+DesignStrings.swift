//
//  DesignSystem+DesignStrings.swift
//  DesignSystem
//
//  Created by Yo'ldoshev Asadbek on 04/08/2025.
//

import Foundation

public extension DesignSystemProvider {
    enum DesignSystemsStrings {
        public static func localized(_ key: String) -> String {
            let bundle = Bundle.designSystem
            return NSLocalizedString(key, bundle: bundle, comment: "")
        }
        public static var homeTitle: String { localized("home_title") }
        public static var driverTitle: String { localized("driver_title") }
        public static var myTripsTitle: String { localized("my_trips_title") }
        public static var profileTitle: String { localized("profile_title") }
        public static var searchPlaceholder: String { localized("search_placeholder") }
        public static var bookButton: String { localized("book_button") }
        public static var seatsAvailable: String { localized("seats_available") }
        public static var priceLabel: String { localized("price_label") }
        public static var confirmButton: String { localized("confirm_button") }
        public static var cancelButton: String { localized("cancel_button") }
        public static var logoutButton: String { localized("logout_button") }
        public static var loginButton: String { localized("login_button") }
        public static var signupButton: String { localized("signup_button") }
        public static var settingsTitle: String { localized("settings_title") }
        public static var languageTitle: String { localized("language_title") }
        public static var noTripsFound: String { localized("no_trips_found") }
        public static var tripDetailsTitle: String { localized("trip_details_title") }
        public static var paymentTitle: String { localized("payment_title") }
        public static var successMessage: String { localized("success_message") }
        public static var errorMessage: String { localized("error_message") }
        public static var retryButton: String { localized("retry_button") }
        public static var departureTime: String { localized("departure_time") }
        public static var arrivalTime: String { localized("arrival_time") }
        public static var fromLabel: String { localized("from_label") }
        public static var toLabel: String { localized("to_label") }
        public static var passengersLabel: String { localized("passengers_label") }
        public static var tripDuration: String { localized("trip_duration") }
        public static var distanceLabel: String { localized("distance_label") }
        public static var todayLabel: String { localized("today_label") }
        public static var tomorrowLabel: String { localized("tomorrow_label") }
        public static var yesterdayLabel: String { localized("yesterday_label") }
        public static var saveButton: String { localized("save_button") }
        public static var deleteButton: String { localized("delete_button") }
        public static var editButton: String { localized("edit_button") }
        public static var searchButton: String { localized("search_button") }
        public static var upcomingTrips: String { localized("upcoming_trips") }
        public static var pastTrips: String { localized("past_trips") }
        public static var totalPrice: String { localized("total_price") }
        public static var perPerson: String { localized("per_person") }
        public static var carLabel: String { localized("car_label") }
        public static var driverName: String { localized("driver_name") }
        public static var contactDriver: String { localized("contact_driver") }
        public static var tripRules: String { localized("trip_rules") }
        public static var luggageAllowed: String { localized("luggage_allowed") }
        public static var petsAllowed: String { localized("pets_allowed") }
        public static var smokingAllowed: String { localized("smoking_allowed") }
        public static var paymentMethod: String { localized("payment_method") }
        public static var cashPayment: String { localized("cash_payment") }
        public static var cardPayment: String { localized("card_payment") }
        public static var seatsTaken: String { localized("seats_taken") }
        public static var availableSeats: String { localized("available_seats") }
        public static var filterTitle: String { localized("filter_title") }
        public static var sortByPrice: String { localized("sort_by_price") }
        public static var sortByTime: String { localized("sort_by_time") }
        public static var sortByDistance: String { localized("sort_by_distance") }
        public static var clearFilters: String { localized("clear_filters") }
        public static var applyFilters: String { localized("apply_filters") }
        public static var notificationTitle: String { localized("notification_title") }
        public static var enableNotifications: String { localized("enable_notifications") }
        public static var disableNotifications: String { localized("disable_notifications") }
        public static var tripCanceled: String { localized("trip_canceled") }
        public static var tripFull: String { localized("trip_full") }
        public static var addTrip: String { localized("add_trip") }
        public static var editTrip: String { localized("edit_trip") }
        public static var deleteTrip: String { localized("delete_trip") }
        public static var messageDriver: String { localized("message_driver") }
        public static var callDriver: String { localized("call_driver") }
        public static var rideSharing: String { localized("ride_sharing") }
        public static var findADriver: String { localized("find_a_driver") }
        public static var findAPassenger: String { localized("find_a_passenger") }
        public static var appVersion: String { localized("app_version") }
        public static var helpTitle: String { localized("help_title") }
        public static var termsTitle: String { localized("terms_title") }
        public static var privacyPolicy: String { localized("privacy_policy") }
        public static var aboutUs: String { localized("about_us") }
        public static var contactUs: String { localized("contact_us") }
        public static var rateApp: String { localized("rate_app") }
        public static var shareApp: String { localized("share_app") }
        public static var loadingLabel: String { localized("loading_label") }
        public static var updatingLabel: String { localized("updating_label") }
        public static var sendingLabel: String { localized("sending_label") }
        public static var receivingLabel: String { localized("receiving_label") }
        public static var yesButton: String { localized("yes_button") }
        public static var noButton: String { localized("no_button") }
        public static var okButton: String { localized("ok_button") }
        public static var skipButton: String { localized("skip_button") }
        public static var doneButton: String { localized("done_button") }
        public static var welcomeMessage: String { localized("welcome_message") }
        public static var introText: String { localized("intro_text") }
        public static var howItWorks: String { localized("how_it_works") }
        public static var stepOne: String { localized("step_one") }
        public static var stepTwo: String { localized("step_two") }
        public static var stepThree: String { localized("step_three") }
        public static var errorNoConnection: String { localized("error_no_connection") }
        public static var errorServer: String { localized("error_server") }
        public static var errorTimeout: String { localized("error_timeout") }
        public static var tryAgainLater: String { localized("try_again_later") }
        public static var searchingRides: String { localized("searching_rides") }
        public static var noResults: String { localized("no_results") }
        public static var tripCreated: String { localized("trip_created") }
        public static var tripUpdated: String { localized("trip_updated") }
        public static var tripDeleted: String { localized("trip_deleted") }
        public static var editProfile: String { localized("edit_profile") }
    }
}

//MARK: Изменил на homeTitle, settingsTitle
/*
 public static var homeNavTitle: String { localized("home_nav_title") }
 public static var settings: String { localized("settings") }
 */
