import Foundation

// MARK: - Supabase Configuration

enum SupabaseConfig {
    // TODO: Replace with actual Supabase project credentials
    static let projectURL = "https://your-project.supabase.co"
    static let anonKey = "your-anon-key"

    // For local development/demo, use mock data
    static let useMockData = true
}

// MARK: - Supabase Client

actor SupabaseClient {
    static let shared = SupabaseClient()

    private init() {}

    // MARK: - Generic Fetch

    func fetch<T: Decodable>(
        from table: String,
        query: QueryBuilder = QueryBuilder()
    ) async throws -> [T] {
        if SupabaseConfig.useMockData {
            return try await MockDataProvider.fetch(from: table, query: query)
        }

        // Real Supabase implementation
        let url = buildURL(table: table, query: query)
        var request = URLRequest(url: url)
        request.setValue("Bearer \(SupabaseConfig.anonKey)", forHTTPHeaderField: "Authorization")
        request.setValue(SupabaseConfig.anonKey, forHTTPHeaderField: "apikey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw SupabaseError.requestFailed
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode([T].self, from: data)
    }

    // MARK: - URL Builder

    private func buildURL(table: String, query: QueryBuilder) -> URL {
        var components = URLComponents(string: "\(SupabaseConfig.projectURL)/rest/v1/\(table)")!
        components.queryItems = query.build()
        return components.url!
    }
}

// MARK: - Query Builder

struct QueryBuilder {
    private var filters: [(String, String, String)] = []
    private var selects: [String] = ["*"]
    private var orders: [(String, Bool)] = []
    private var limitValue: Int?
    private var offsetValue: Int?

    func select(_ columns: String...) -> QueryBuilder {
        var copy = self
        copy.selects = columns
        return copy
    }

    func eq(_ column: String, _ value: String) -> QueryBuilder {
        var copy = self
        copy.filters.append((column, "eq", value))
        return copy
    }

    func `in`(_ column: String, _ values: [String]) -> QueryBuilder {
        var copy = self
        let valueList = "(\(values.joined(separator: ",")))"
        copy.filters.append((column, "in", valueList))
        return copy
    }

    func gte(_ column: String, _ value: String) -> QueryBuilder {
        var copy = self
        copy.filters.append((column, "gte", value))
        return copy
    }

    func lte(_ column: String, _ value: String) -> QueryBuilder {
        var copy = self
        copy.filters.append((column, "lte", value))
        return copy
    }

    func ilike(_ column: String, _ pattern: String) -> QueryBuilder {
        var copy = self
        copy.filters.append((column, "ilike", "*\(pattern)*"))
        return copy
    }

    func order(_ column: String, ascending: Bool = true) -> QueryBuilder {
        var copy = self
        copy.orders.append((column, ascending))
        return copy
    }

    func limit(_ count: Int) -> QueryBuilder {
        var copy = self
        copy.limitValue = count
        return copy
    }

    func offset(_ count: Int) -> QueryBuilder {
        var copy = self
        copy.offsetValue = count
        return copy
    }

    func build() -> [URLQueryItem] {
        var items: [URLQueryItem] = []

        items.append(URLQueryItem(name: "select", value: selects.joined(separator: ",")))

        for (column, op, value) in filters {
            items.append(URLQueryItem(name: column, value: "\(op).\(value)"))
        }

        for (column, ascending) in orders {
            items.append(URLQueryItem(name: "order", value: "\(column).\(ascending ? "asc" : "desc")"))
        }

        if let limit = limitValue {
            items.append(URLQueryItem(name: "limit", value: String(limit)))
        }

        if let offset = offsetValue {
            items.append(URLQueryItem(name: "offset", value: String(offset)))
        }

        return items
    }
}

// MARK: - Errors

enum SupabaseError: Error {
    case requestFailed
    case decodingFailed
    case notFound
}
