//
//  ProductModel.swift
//  MOOD2
//
//  Created by NOY on 09.10.2024.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let products: [Product]
    let combo: [JSONAny]
    let sorts: [Sort]
    let page: Page
}

// MARK: - Page
struct Page: Codable {
    let page, limit, count: Int
}

// MARK: - Product
struct Product: Codable, Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.availability == rhs.availability &&
        lhs.price == rhs.price &&
        lhs.variants == rhs.variants &&
        lhs.isActive == rhs.isActive
    }
    
    let id, code, type, title: String
    let article: String
    let availability: Bool
    let availabilityCount: Int
    let media: [Media]
    let price: Price
    let categoryID: String
    let categoryIDList: [String]
    let nameplates, properties: [JSONAny]
    let variants: [Variant]
    let variantOptions: [VariantOption]
    let isActive: Bool
    let sort: Int
    
    enum CodingKeys: String, CodingKey {
        case id, code, type, title, article, availability, availabilityCount, media, price
        case categoryID = "categoryId"
        case categoryIDList = "categoryIdList"
        case nameplates, properties, variants, variantOptions, isActive, sort
    }
}

// MARK: - Media
struct Media: Codable, Hashable {
    let type, title, url, alternative: String
}

// MARK: - Price
struct Price: Codable, Equatable {
    static func == (lhs: Price, rhs: Price) -> Bool {
        return lhs.main == rhs.main &&
        lhs.base == rhs.base &&
        lhs.baseDiscount == rhs.baseDiscount &&
        lhs.mainDiscount == rhs.mainDiscount &&
        lhs.additional.count == rhs.additional.count
    }
    
    let main, base, baseDiscount, mainDiscount: Base
    let additional: [JSONAny]
}

// MARK: - Base
struct Base: Codable, Equatable {
    static func == (lhs: Base, rhs: Base) -> Bool {
        return lhs.price == rhs.price &&
        lhs.currency == rhs.currency &&
        lhs.unit == rhs.unit
    }
    
    let price: Int
    let currency: String
    let unit: String?
}

// MARK: - VariantOption
struct VariantOption: Codable, Equatable {
    static func == (lhs: VariantOption, rhs: VariantOption) -> Bool {
        return lhs.id == rhs.id &&
        lhs.code == rhs.code &&
        lhs.title == rhs.title &&
        lhs.icon == rhs.icon &&
        lhs.value == rhs.value
    }
    
    let id: String?
    let code, title: String
    let icon: Media?
    let value: String?
}

// MARK: - Variant
struct Variant: Codable, Equatable {
    static func == (lhs: Variant, rhs: Variant) -> Bool {
        return lhs.id == rhs.id &&
        lhs.code == rhs.code &&
        lhs.title == rhs.title &&
        lhs.xmlID == rhs.xmlID &&
        lhs.isCurrent == rhs.isCurrent &&
        lhs.availability == rhs.availability &&
        lhs.availabilityCount == rhs.availabilityCount &&
        lhs.variantOptionValues == rhs.variantOptionValues
    }
    
    let id, code, title, xmlID: String
    let isCurrent, availability: Bool
    let availabilityCount: Int
    let variantOptionValues: [VariantOption]
    
    enum CodingKeys: String, CodingKey {
        case id, code, title
        case xmlID = "xmlId"
        case isCurrent, availability, availabilityCount, variantOptionValues
    }
}

// MARK: - Sort
struct Sort: Codable {
    let direction, title: String
    let isApplied: Bool
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
