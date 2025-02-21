# Async-Await

## Async/Await, Actors, Async-Let, Task Groups, Unstructured Concurrency

This project demonstrates the use of Swift's `async` and `await` features to handle asynchronous programming in an iOS application. It includes examples of fetching data from a remote API, performing background tasks, and updating the UI smoothly.

## Features
- Fetch data from a remote API using `URLSession` with `async/await`
- Perform background tasks efficiently
- Handle errors using Swift's structured concurrency model
- Update UI elements asynchronously on the main thread
- Implement `Async-Let` for concurrent execution of multiple tasks
- Use `Task Groups` for managing structured concurrency

## Installation
1. Clone this repository:
   ```sh
   git clone https://github.com/niyatipatel97/Async-Await.git
   ```
2. Open the project in Xcode:
   ```sh
   cd RandomQuoteAndImages
   open RandomQuoteAndImages.xcodeproj
   ```
3. Build and run the app on a simulator or a real device.

## Usage
- Run the app or tap the reload data button on top right corner to see how async-await handles API calls.
- Modify the `Webservice.swift` file to experiment with different async operations.

##Demo
[Click to see app preview](https://drive.google.com/file/d/1gdEw_El3V-jbzdnddiO-T69qtBSB6rsJ/view?usp=sharing)
![](https://drive.google.com/file/d/1gdEw_El3V-jbzdnddiO-T69qtBSB6rsJ/view?usp=sharing)

## Example Code
```swift
func getRandomImage(id: Int) async throws -> RandomImage {
    
    guard let url = Constants.Urls.getRandomImageUrl() else {
        throw NetworkError.badUrl
    }
    
    guard let randomQuoteUrl = Constants.Urls.randomQuoteUrl else {
        throw NetworkError.badUrl
    }
    
    async let (imageData, _) = URLSession.shared.data(from: url)
    async let (randomQuoteData, _) = URLSession.shared.data(from: randomQuoteUrl)
    
    guard let quote = try? JSONDecoder().decode(Quote.self, from: try await randomQuoteData) else {
        throw NetworkError.decodingError
    }
    
    return RandomImage(image: try await imageData, quote: quote)
}
```

```swift
func getRandomImages(ids: [Int]) async {
        
    let webservice = Webservice()
    self.randomImages = []
    do {
        try await withThrowingTaskGroup(of: (Int, RandomImage).self) { group in
            
            for id in ids {
                group.addTask {
                    return (id, try await webservice.getRandomImage(id: id))
                }
            }
            for try await (_, randomImage) in group {
                randomImages.append(RandomImageViewModel(randomImage: randomImage))
            }
        }
    } catch {
        print(error)
    }
}
```

## Contact
For any inquiries, please contact [patelniyati97@gamil.com](mailto:patelniyati97@gamil.com).
