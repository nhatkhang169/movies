// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Duration {
    /// h
    internal static let hour = L10n.tr("Localizable", "Duration.Hour", fallback: #"h"#)
    /// min
    internal static let minute = L10n.tr("Localizable", "Duration.Minute", fallback: #"min"#)
  }
  internal enum Genre {
    /// Action
    internal static let action = L10n.tr("Localizable", "Genre.Action", fallback: #"Action"#)
    /// Adventure
    internal static let adventure = L10n.tr("Localizable", "Genre.Adventure", fallback: #"Adventure"#)
    /// Animation
    internal static let animation = L10n.tr("Localizable", "Genre.Animation", fallback: #"Animation"#)
    /// Comedy
    internal static let comedy = L10n.tr("Localizable", "Genre.Comedy", fallback: #"Comedy"#)
    /// Crime
    internal static let crime = L10n.tr("Localizable", "Genre.Crime", fallback: #"Crime"#)
    /// Drama
    internal static let drama = L10n.tr("Localizable", "Genre.Drama", fallback: #"Drama"#)
    /// Sci-Fi
    internal static let sf = L10n.tr("Localizable", "Genre.SF", fallback: #"Sci-Fi"#)
  }
  internal enum MovieDetail {
    /// Details
    internal static let details = L10n.tr("Localizable", "MovieDetail.Details", fallback: #"Details"#)
    /// Genre
    internal static let genre = L10n.tr("Localizable", "MovieDetail.Genre", fallback: #"Genre"#)
    /// Released date
    internal static let releaseDate = L10n.tr("Localizable", "MovieDetail.ReleaseDate", fallback: #"Released date"#)
    /// Short description
    internal static let shortDesc = L10n.tr("Localizable", "MovieDetail.ShortDesc", fallback: #"Short description"#)
    internal enum Button {
      /// · ADD TO WATCHLIST
      internal static let addToWatchList = L10n.tr("Localizable", "MovieDetail.Button.AddToWatchList", fallback: #"· ADD TO WATCHLIST"#)
      /// REMOVE FROM WATCHLIST
      internal static let removeFromWatchList = L10n.tr("Localizable", "MovieDetail.Button.RemoveFromWatchList", fallback: #"REMOVE FROM WATCHLIST"#)
      /// WATCH TRAILER
      internal static let watchTrailer = L10n.tr("Localizable", "MovieDetail.Button.WatchTrailer", fallback: #"WATCH TRAILER"#)
    }
  }
  internal enum MovieTrailer {
    internal enum Button {
      /// Exit
      internal static let exit = L10n.tr("Localizable", "MovieTrailer.Button.Exit", fallback: #"Exit"#)
    }
  }
  internal enum Movies {
    /// Localizable.strings
    ///   movies
    /// 
    ///   Created by azun on 29/08/2023.
    internal static let title = L10n.tr("Localizable", "Movies.Title", fallback: #"Movies"#)
    internal enum Button {
      /// Sort
      internal static let sort = L10n.tr("Localizable", "Movies.Button.Sort", fallback: #"Sort"#)
    }
    internal enum Label {
      /// ON MY WATCHLIST
      internal static let onMyWatchList = L10n.tr("Localizable", "Movies.Label.OnMyWatchList", fallback: #"ON MY WATCHLIST"#)
    }
    internal enum SortBy {
      /// Cancel
      internal static let cancel = L10n.tr("Localizable", "Movies.SortBy.Cancel", fallback: #"Cancel"#)
      /// Released Date
      internal static let releasedDate = L10n.tr("Localizable", "Movies.SortBy.ReleasedDate", fallback: #"Released Date"#)
      /// Title
      internal static let title = L10n.tr("Localizable", "Movies.SortBy.Title", fallback: #"Title"#)
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
