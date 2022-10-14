import { TodoList } from "../models/todoList.js";
import { TodoItem } from "./todoItem.js";

/**
 * AppRoot is a custom HTML5 component.  Its style is declared in appRoot.css,
 * and its structure is declared in appRoot.html.
 *
 * AppRoot will be available to the application via the tag `<app-root>`.  It
 * has two main parts: a list of elements and a button.
 *
 * In order to make this component self-contained, it has a static `init`
 * function.  When initializing a web app, be sure to call this `init` function
 * to make app-root into a valid HTML tag.
 */
export class AppRoot extends HTMLElement {
  // Note that the use of `templatePath`, `tagName`, `template`, and `init` is
  // an attempt to make HTML5 components more maintainable.  If we had a build
  // tool, like webpack, or a framework, like react, they would do most of
  // this work for us.

  /** The html file to use for the template */
  static #templatePath = "src/components/appRoot.html";

  /** The tag name associated with this element */
  static #tagName = "app-root";

  /** The HTML template to use when making this component */
  static #template = undefined;

  /** The HTML tag with all the items in it */
  #items;

  /** The HTML button for adding */
  #addBtn;

  /** Create the app-root tag */
  static async init() {
    // Fetch the template's HTML, convert it to text
    let src = await fetch(AppRoot.#templatePath);
    let txt = await src.text();
    // Inject a template into the document head.  The template body is the
    // HTML we just fetched.
    AppRoot.#template = document.createElement("template");
    AppRoot.#template.innerHTML = txt;
    document.head.appendChild(AppRoot.#template);
    // Associate this type (AppRoot) with the tag "app-root"
    window.customElements.define(AppRoot.#tagName, AppRoot);
  }

  /**
   * Each time there is an `app-root` tag in the HTML document, this
   * constructor will be called to create the associated HTML element.
   */
  constructor() {
    // Since this extends HTMLElement, we need to make ourselves a proper
    // HTMLElement first.
    super();

    // The "DOM" (document object model) is just a tree of HTML objects.  We
    // attach a "shadow DOM" to our HTML element, because right now this is
    // just a plain-old HTMLElement, which has nothing in it, and we want a
    // nice tree of stuff (i.e., the stuff in our appRoot.html file!).
    this.attachShadow({ mode: "open" });

    // Now that we have a shadow DOM, we can make a copy of our template and
    // set it as the child of our shadow DOM.  That injects our HTML into
    // the document, and lets us access it from the shadow DOM.  Part of
    // what is nice about the shadow DOM is that it is self-contained: when
    // we put styles in it, or when we look for HTML elements in it, we
    // start at its root, not the whole document.
    this.shadowRoot.appendChild(AppRoot.#template.content.cloneNode(true));

    // Find the div that wil hold our todo items, and find the button for
    // adding new todo items to the list.  We can think of these as being
    // "fields" of this object, but since we're writing JavaScript, there
    // aren't really declared anywhere... we just add them to `this`.
    this.#items = this.shadowRoot.querySelector("div");
    this.#addBtn = this.shadowRoot.querySelector("button");
  }

  /**
   * Whenever an `app-root` is added to the document, this will be called.
   * Its job is to specify what to do when the "add" button is clicked.
   */
  connectedCallback() {
    // When the add button is clicked, call our "addTodoItem" method, and
    // pass it the object describing the click event.
    this.#addBtn.addEventListener("click", (e) => this.#addTodoItem(e));
  }

  /**
   * In response to a click of our "add" button, add a todo-item tag.
   *
   * @param e The click event
   */
  #addTodoItem(e) {
    // We're fully handling the click, so don't pass the click on down to
    // other objects that are under this button.
    e.stopPropagation();

    // Get a new object from the model, use it to make a todo-item tag and
    // add it to the list
    let data = TodoList.CreateItem();
    let todoItem = document.createElement(TodoItem.tagName);
    todoItem.setData(data);
    this.#items.appendChild(todoItem);
  }

  /**
   * When an AppRoot tag is removed from the document, this will be called.
   * In our app, it doesn't do anything.
   */
  disconnectedCallback() {}
}
