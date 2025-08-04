<h1>SudoGo</h1>
        <p class="text-gray-700">A modern and responsive Sudoku game built with Flutter. It utilizes the BLoC state management pattern to provide a clean, user-friendly interface with features like dynamic puzzle generation and local data persistence.</p>
        <h2 class="text-purple-600">✨ Features</h2>
        <ul class="list-disc pl-5">
            <li><strong>Dynamic Puzzle Generation</strong>: A unique Sudoku puzzle is generated every time you start a new game.</li>
            <li><strong>Offline Data Persistence</strong>: Game progress is automatically saved to a local SQLite database using <strong>Drift</strong>, allowing you to continue your game even after closing the app.</li>
            <li><strong>Real-time Validation</strong>: Cells with incorrect numbers are highlighted in real-time, providing immediate feedback.</li>
            <li><strong>Responsive UI</strong>: The layout adapts seamlessly to both portrait and landscape orientations on various devices.</li>
            <li><strong>Game Controls</strong>: Easy-to-use buttons for clearing a cell, resetting the entire puzzle, or starting a new game.</li>
            <li><strong>Splash Screen</strong>: A sleek, animated splash screen for a polished and engaging app launch experience.</li>
            <li><strong>Confirmation Dialogs</strong>: Dialogs appear for critical actions like clearing or resetting to prevent accidental loss of progress.</li>
        </ul>
        <h2 class="text-purple-600">🚀 Getting Started</h2>
        <p class="text-gray-700">Follow these steps to run the project locally on your machine.</p>
        <h3 class="text-blue-600">Prerequisites</h3>
        <ul class="list-disc pl-5">
            <li><strong>Flutter SDK</strong>: Ensure you have Flutter installed.</li>
            <li><strong>Drift Build Runner</strong>: The project uses <code>drift</code> for the database, which requires a code generator. You'll need to run a command to generate the necessary files.</li>
        </ul>
        <h2 class="text-purple-600">🏗️ Architecture</h2>
        <p class="text-gray-700">This project is built using the <strong>BLoC (Business Logic Component)</strong> pattern to separate the UI from the business logic.</p>
        <ul class="list-disc pl-5">
            <li><strong><code>sudoku_bloc.dart</code></strong>: Manages the game's state, including the board, selected cells, validation logic, and interaction with the database.</li>
            <li><strong><code>sudoku_event.dart</code></strong>: Defines all possible user actions (e.g., <code>CellTappedEvent</code>, <code>NewGameEvent</code>).</li>
            <li><strong><code>sudoku_state.dart</code></strong>: Represents the different states of the game (e.g., <code>SudokuInitial</code>, <code>SudokuLoaded</code>).</li>
            <li><strong><code>sudoku_game_screen.dart</code></strong>: The main UI widget that listens to state changes from the BLoC and renders the appropriate view.</li>
            <li><strong><code>database.dart</code></strong>: Uses the <strong>Drift</strong> library to define the local SQLite database schema and methods for saving and retrieving game data.</li>
        </ul>
        <h2 class="text-purple-600">🤝 How to Contribute</h2>
        <p class="text-gray-700">Contributions are welcome! If you'd like to contribute to this project, please follow these steps:</p>
        <ol class="list-decimal pl-5">
            <li><strong>Fork the repository.</strong></li>
            <li><strong>Create a new branch</strong> for your feature or bug fix.</li>
            <li><strong>Make your changes</strong> and commit them with a clear and descriptive message.</li>
            <li><strong>Push your changes</strong> to your fork.</li>
            <li><strong>Create a pull request</strong> to the main repository.</li>
        </ol>
        <h2 class="text-purple-600">📄 License</h2>
        <p class="text-gray-700">This project is licensed under the MIT License. See the <a href="https://www.google.com/search?q=LICENSE" class="text-blue-600 hover:underline">LICENSE</a> file for more details.</p>
        <h2 class="text-purple-600">Created By</h2>
        <ul class="list-disc pl-5">
            <li><a href="https://in.linkedin.com/in/bhavesh-shiyani-b3471a48" class="text-blue-600 hover:underline"><strong>Bhavesh Shiyani</strong></a></li>
        </ul>
