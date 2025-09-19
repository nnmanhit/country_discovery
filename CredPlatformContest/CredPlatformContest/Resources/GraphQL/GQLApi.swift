// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ContinentQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query continent($code: ID!) {
      continent(code: $code) {
        __typename
        code
        countries {
          __typename
          ...FGCountry
        }
      }
    }
    """

  public let operationName: String = "continent"

  public var queryDocument: String { return operationDefinition.appending("\n" + FgCountry.fragmentDefinition).appending("\n" + FgLanguage.fragmentDefinition) }

  public var code: GraphQLID

  public init(code: GraphQLID) {
    self.code = code
  }

  public var variables: GraphQLMap? {
    return ["code": code]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("continent", arguments: ["code": GraphQLVariable("code")], type: .object(Continent.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(continent: Continent? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "continent": continent.flatMap { (value: Continent) -> ResultMap in value.resultMap }])
    }

    public var continent: Continent? {
      get {
        return (resultMap["continent"] as? ResultMap).flatMap { Continent(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "continent")
      }
    }

    public struct Continent: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Continent"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("code", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("countries", type: .nonNull(.list(.nonNull(.object(Country.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(code: GraphQLID, countries: [Country]) {
        self.init(unsafeResultMap: ["__typename": "Continent", "code": code, "countries": countries.map { (value: Country) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var code: GraphQLID {
        get {
          return resultMap["code"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "code")
        }
      }

      public var countries: [Country] {
        get {
          return (resultMap["countries"] as! [ResultMap]).map { (value: ResultMap) -> Country in Country(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Country) -> ResultMap in value.resultMap }, forKey: "countries")
        }
      }

      public struct Country: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Country"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(FgCountry.self),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var fgCountry: FgCountry {
            get {
              return FgCountry(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class CountriesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query countries($lang: String) {
      countries {
        __typename
        name(lang: $lang)
        ...FGCountry
      }
    }
    """

  public let operationName: String = "countries"

  public var queryDocument: String { return operationDefinition.appending("\n" + FgCountry.fragmentDefinition).appending("\n" + FgLanguage.fragmentDefinition) }

  public var lang: String?

  public init(lang: String? = nil) {
    self.lang = lang
  }

  public var variables: GraphQLMap? {
    return ["lang": lang]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("countries", type: .nonNull(.list(.nonNull(.object(Country.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(countries: [Country]) {
      self.init(unsafeResultMap: ["__typename": "Query", "countries": countries.map { (value: Country) -> ResultMap in value.resultMap }])
    }

    public var countries: [Country] {
      get {
        return (resultMap["countries"] as! [ResultMap]).map { (value: ResultMap) -> Country in Country(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Country) -> ResultMap in value.resultMap }, forKey: "countries")
      }
    }

    public struct Country: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Country"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", arguments: ["lang": GraphQLVariable("lang")], type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(FgCountry.self),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var fgCountry: FgCountry {
          get {
            return FgCountry(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct FgCountry: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment FGCountry on Country {
      __typename
      awsRegion
      capital
      code
      currency
      languages {
        __typename
        ...FGLanguage
      }
    }
    """

  public static let possibleTypes: [String] = ["Country"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("awsRegion", type: .nonNull(.scalar(String.self))),
      GraphQLField("capital", type: .scalar(String.self)),
      GraphQLField("code", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("currency", type: .scalar(String.self)),
      GraphQLField("languages", type: .nonNull(.list(.nonNull(.object(Language.selections))))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(awsRegion: String, capital: String? = nil, code: GraphQLID, currency: String? = nil, languages: [Language]) {
    self.init(unsafeResultMap: ["__typename": "Country", "awsRegion": awsRegion, "capital": capital, "code": code, "currency": currency, "languages": languages.map { (value: Language) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var awsRegion: String {
    get {
      return resultMap["awsRegion"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "awsRegion")
    }
  }

  public var capital: String? {
    get {
      return resultMap["capital"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "capital")
    }
  }

  public var code: GraphQLID {
    get {
      return resultMap["code"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "code")
    }
  }

  public var currency: String? {
    get {
      return resultMap["currency"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "currency")
    }
  }

  public var languages: [Language] {
    get {
      return (resultMap["languages"] as! [ResultMap]).map { (value: ResultMap) -> Language in Language(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: Language) -> ResultMap in value.resultMap }, forKey: "languages")
    }
  }

  public struct Language: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Language"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(FgLanguage.self),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(code: GraphQLID, name: String, native: String, rtl: Bool) {
      self.init(unsafeResultMap: ["__typename": "Language", "code": code, "name": name, "native": native, "rtl": rtl])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var fgLanguage: FgLanguage {
        get {
          return FgLanguage(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}

public struct FgLanguage: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment FGLanguage on Language {
      __typename
      code
      name
      native
      rtl
    }
    """

  public static let possibleTypes: [String] = ["Language"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("code", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
      GraphQLField("native", type: .nonNull(.scalar(String.self))),
      GraphQLField("rtl", type: .nonNull(.scalar(Bool.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(code: GraphQLID, name: String, native: String, rtl: Bool) {
    self.init(unsafeResultMap: ["__typename": "Language", "code": code, "name": name, "native": native, "rtl": rtl])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var code: GraphQLID {
    get {
      return resultMap["code"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "code")
    }
  }

  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var native: String {
    get {
      return resultMap["native"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "native")
    }
  }

  public var rtl: Bool {
    get {
      return resultMap["rtl"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "rtl")
    }
  }
}

public struct FgContinent: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment FGContinent on Continent {
      __typename
      code
      countries {
        __typename
        ...FGCountry
      }
      name
    }
    """

  public static let possibleTypes: [String] = ["Continent"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("code", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("countries", type: .nonNull(.list(.nonNull(.object(Country.selections))))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(code: GraphQLID, countries: [Country], name: String) {
    self.init(unsafeResultMap: ["__typename": "Continent", "code": code, "countries": countries.map { (value: Country) -> ResultMap in value.resultMap }, "name": name])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var code: GraphQLID {
    get {
      return resultMap["code"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "code")
    }
  }

  public var countries: [Country] {
    get {
      return (resultMap["countries"] as! [ResultMap]).map { (value: ResultMap) -> Country in Country(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: Country) -> ResultMap in value.resultMap }, forKey: "countries")
    }
  }

  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public struct Country: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Country"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(FgCountry.self),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var fgCountry: FgCountry {
        get {
          return FgCountry(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}
