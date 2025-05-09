import Foundation

// A generic helper to perform building fetches, normalizing input and managing loading/error state.
func performFetchData<Model>(
    for rawInput: String,
    serviceFetch: @escaping (String, @escaping (Result<[Model], Error>) -> Void) -> Void,
    onResult: @escaping ([Model]) -> Void,
    onError: @escaping (String) -> Void,
    onLoading: @escaping (Bool) -> Void,
    onSearched: @escaping (Bool) -> Void
) {
    onLoading(true)
    let normalized = rawInput
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .lowercased()
        .capitalized

    serviceFetch(normalized) { result in
        DispatchQueue.main.async {
            onLoading(false)
            switch result {
            case .success(let items):
                onResult(items)
                onSearched(true)
            case .failure(let error):
                onError(error.localizedDescription)
                onSearched(true)
            }
        }
    }
}
