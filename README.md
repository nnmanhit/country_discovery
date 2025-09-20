# Country Discovery
<h3>Welcome to my country discovery application!</h3>
<h3> A mobile application built to discover countries and their details.</h3>
<br>
<img width="1024" height="488" alt="banner" src="https://github.com/user-attachments/assets/e9ad8270-8eeb-4d4e-8fd7-105a0df54249" />

<h1>General</h1>
<p>
  Build a SwiftUI iOS app that fetches data from a public GraphQL API and uses a free-tier LLM API (e.g., OpenAI, Cohere, or Gemini) to provide lightweight natural language insights or summarization.
</p>

<h1>App Screenshots</h1>
<div style = "float: left;">
  <img width="400" height="850" alt="IMG_3307" src="https://github.com/user-attachments/assets/3aedab5e-c14c-4e80-9924-20979e563bcb" />
  <img width="400" height="850" alt="IMG_3308" src="https://github.com/user-attachments/assets/a8962c2c-e818-48f2-a405-891d0d5dd3ea" />
</div>

<h1>Goals</h1>
<p>The application is built under MVVM Architecture along with the latest technique such as SwiftUI, Combine, Concurrency (Async/Await). The app has to be follow these important goals</p>
<ul>
  <li>Scalability</li>
  <li>Maintainability</li>
  <li>Tesable</li>
  <li>Modularity</li>
</ul>

<h1>Architecture</h1>
<br/>
<br/>
<img width="997" height="781" alt="Screenshot 2025-09-19 at 5 43 40 PM" src="https://github.com/user-attachments/assets/e4cbdec4-1231-4244-b23f-3cbe4fc06002" />
<br/>
<p>
  The core of this architecture is the ViewModel, which acts as the intermediary between the View and the various data and service layers. The View is kept simple, focusing only on displaying data and handling user interactions. It communicates with the ViewModel, which in turn manages all the business logic, data fetching, and state management. The ViewModel accesses data from several service layers, including those for storage, APIs, and databases. This separation of concerns makes the code more modular, testable, and easier to maintain.
</p>
<h3>Explanation of Each Component</h3>
<h4>View & ViewModel:</h4>
<p>
  <p>View: This is the user interface layer of the application. Its primary responsibility is to render the UI elements and send user actions (like button taps) to the ViewModel. It holds a reference to the ViewModel but has no knowledge of the underlying data sources or business logic.</p>
<p>ViewModel: This is the brain of the architecture. It exposes data that the View can bind to and provides methods that the View can call to perform actions. It contains the business logic and orchestrates data flow by communicating with various services. The ViewModel is completely independent of the View, which makes it easily testable.</p>
</p>
<h4>Model Layers:</h4>
<p>
  <ul>
  <li>StorageService: This is a protocol or an abstraction that defines methods for persistent data storage.</li>

<li>UserDefaultsService: This service handles lightweight, key-value data storage using UserDefaults. It's a common way to store user preferences or small amounts of non-critical data.</li>

<li>RealmService: This service manages interactions with the Realm Database, a mobile database solution. It contains RealmObjects like CountryRealm and ContinentRealm which are data models for the database.</li>

<li>APIService: This is an abstraction for all API-related logic. It likely defines methods for making network requests.</li>

<li>OpenAIService & GeminiAIService: These are specific API services for interacting with AI models from OpenAI and Google Gemini. They handle the request and response models (OpenAIRequest, GeminiAIRequest, etc.).</li>

<li>LLMService: An abstraction layer on top of the AI services. It likely provides a unified interface for the ViewModel to interact with any Large Language Model (LLM) without needing to know the specifics of the underlying service (e.g., OpenAI or Gemini).</li>

<li>GraphQL Service: This service handles network requests using GraphQL, likely with a client like ApolloClient and a dedicated cache.</li>

<li>REST (Not Implement Yet): This represents a service for making traditional RESTful API calls, using a RestClient and its own caching mechanism. This one is also implement from the APIServiceProtocol.</li>
</ul>
</p>

<h4>Mocks</h4>
<p>
  <ul><li>MockAPIService: A mock implementation of APIService used for testing. It provides predefined responses, so the ViewModel can be tested without making actual network calls.</li>
  <li>MockLLMService: A mock implementation for the LLMService, used to test the ViewModel's interaction with the LLM layer.</li>
  <li>MockStorageService: A concrete implementation of StorageService used for testing. It simulates the behavior of a real storage service without actually writing to a persistent store. This is crucial for unit testing the ViewModel.</li>
  </ul>
</p>

<img width="1151" height="864" alt="Screenshot 2025-09-19 at 6 27 55 PM" src="https://github.com/user-attachments/assets/fb01c345-e368-4432-9b3f-9c64d1e4f08c" />
<br/>
<br/>

<h1>Class Diagram</h1>
<br>
<img width="1014" height="705" alt="Screenshot 2025-09-19 at 6 50 31 PM" src="https://github.com/user-attachments/assets/6bdf5a9d-923b-4bdc-a33f-04838d429a42" />

<h1>Key Benefits for the Architecture</h1>
<ul>
  <li><p>Separation of Concerns: Each component has a single, well-defined responsibility. The View handles the UI, the ViewModel handles the business logic, and the services handle data management. This makes the code easier to understand and manage.</p></li>
  <li><p>Testability: The core logic resides in the ViewModel, which is independent of the View. By using mock services, you can easily unit test the ViewModel's behavior in isolation without needing to set up a real database or make network calls.</p></li>
  <li><p>Maintainability and Scalability: The modular design allows for changes in one component without affecting others. For example, you can switch from the Realm database to another without rewriting the entire application logic, only the RealmService implementation. Adding new features is also straightforward as you can add new services or logic without disrupting existing code.</p></li>
  <li><p>Improved Code Organization: The clear roles and dependencies between components lead to a well-organized codebase, which is especially beneficial for large projects or teams.</p></li>
  <li><p>Reusability: The ViewModel and service layers can be reused in different parts of the application or even in a different application altogether.</p></li>
</ul>

<h1>Trade-Off</h1>
<ul>
  <li><p>That MVVM architecture, while powerful, comes with some key trade-offs. The main trade-off is the increased complexity and boilerplate code you need to write upfront. This can be overkill for small, simple applications but pays off in the long run for larger, more complex ones.</p></li>
  <li><p>You'll write more code to set up the architecture. For every feature, you'll likely need a View, a ViewModel, and possibly a new Service or an extension to an existing one. This can feel tedious for simple tasks that could be done with a single class :D</p></li>
  <li>The project is built in SwiftUI+Combine which is a new paradym programming like React. This would be a good for future, but for some developers who are not familiar with it, it would be taking time to read the code and debug</li>
</ul>

<h1>Limitations</h1>
<ul>
  <li><p>High Upfront Cost: The initial setup of the project takes longer. You have to create the View, ViewModel, and define the service layers and protocols before you can start implementing the core business logic</p></li>
  <li><p>If not well-managed, the ViewModel can become a dumping ground for all business logic</p></li>
  <li><p>This application hasn't built with not all xctest cases yet. But we can denitely add more</p></li>
</ul>

<h1>Core Technologies</h1>
<ul>
  <li><h3>Data Fetching via GraphQL</h3></li>
  <li><h3>LLM Integration - Easy Swapping</h3></li>
  <li><h3>Include accessibility and dark mode support</h3></li>
  <li><h3>GitHub Actions config for build/test</h3></li>
  <li><h3>Add XCTest unit tests for your ViewModels</h3></li>
  <li><h3>Storage for Offline & Favorite</h3></li>
  <li><h3>Modularize the codebase for easy testing</h3></li>
  <li><h3>Use SwiftUI, Concurrency</h3></li>
  <li><h3>Secure API Keys</h3></li>
</ul>

<h1>Libraries</h1>
<ul>
  <li><h3>RealmSwift</h3></li>
  <li><h3>OpenAI APIs</h3></li>
  <li><h3>Gemini AI APIs</h3></li>
  <li><h3>CryptoSwift</h3></li>
  </ul>
  
<h1>Installation</h1>
<p>This project uses CocoaPods to manage its dependencies. To get the project up and running, follow these steps:
Install CocoaPods: If you don't have CocoaPods installed, open your terminal and run the following command:</p>
<p></p><code>sudo gem install cocoapods</code></p>
<br/>
<p>Install Dependencies: Navigate to the CredPlatformContest directory where the Podfile is located and install the required libraries:</p>
<p><code>cd CredPlatformContest
  pod install</code></p>

<p>Open the Project: After the installation is complete, always open the project using the .xcworkspace file, not the .xcodeproj file.</p>
<code>open CredPlatformContest.xcworkspace</code>


