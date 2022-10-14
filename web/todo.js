import { AppRoot } from "./src/components/appRoot.js";
import { TodoItem } from "./src/components/todoItem.js";

/**
 * Blocking function for fetching and initializing each of the HTML5 web
 * components that we will use in our application
 */
async function defineElements() {
  await AppRoot.init();
  await TodoItem.init();
}

// Initialize the elements, and thus populate the page
defineElements();
