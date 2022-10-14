import { TodoList } from "../models/todoList.js";

/**
 * TodoItem is a custom HTML5 component.  Its style is declared in todoItem.css,
 * and its structure is declared in todoItem.html.
 *
 * TodoItem will be available to the application via the tag `<todo-item>`.  It
 * has three parts: a check box, a delete button, and a place where text can be
 * displayed or edited.
 *
 * See appRoot.js for details about the structure of this file.
 */
export class TodoItem extends HTMLElement {
  /** The html file to use for the template */
  static #templatePath = "src/components/todoItem.html";

  /** The tag name associated with this element */
  static tagName = "todo-item";

  /** The HTML template to use when making this component */
  static #template = undefined;

  /** The HTML checkbox */
  #check;

  /** The HTML text input box */
  #input;

  /** The HTML span */
  #display;

  /** The HTML button for deleting */
  #deleteBtn;

  /** The database id associated with this todo-item */
  #id;

  /** Create the todo-item tag */
  static async init() {
    let src = await fetch(TodoItem.#templatePath);
    let txt = await src.text();
    TodoItem.#template = document.createElement("template");
    TodoItem.#template.innerHTML = txt;
    document.head.appendChild(TodoItem.#template);
    window.customElements.define(TodoItem.tagName, TodoItem);
  }

  /**
   * Each time there is a `todo-item` tag in the HTML document, this
   * constructor will be called to create the associated HTML element.
   */
  constructor() {
    super();

    // Set up the shadow DOM stuff
    this.attachShadow({ mode: "open" });
    this.shadowRoot.appendChild(TodoItem.#template.content.cloneNode(true));

    // Find the HTML elements that we'll be manipulating
    let item = this.shadowRoot.querySelector(".todo-item");
    this.#check = item.querySelector("input[type=checkbox]");
    this.#input = item.querySelector("input[type=text]");
    this.#display = item.querySelector("span");
    this.#deleteBtn = item.querySelector("button");
  }

  /** Set the fields of this view based on the data from the model */
  setData(data) {
    this.#input.value = data.data;
    this.#display.innerHTML = data.data;
    this.#id = 0 + data.id;
    this.#check.checked = data.complete;
    if (data.complete) {
      this.#display.classList.add("strike-through");
    }
  }

  /**
   * Set up the listeners for the various events of interest
   */
  connectedCallback() {
    // Set up listeners on the text box, the input box, the delete button,
    // and the check box
    this.#display.addEventListener("click", (e) => this.#editContent(e));
    this.#deleteBtn.addEventListener("click", (e) => this.#deleteTodoItem(e));
    this.#check.addEventListener("click", (e) => this.#toggleCheck(e));
    this.#input.addEventListener("focusout", (e) => this.#saveContent());
  }

  /**
   * In response to a click on the display text, switch to editing mode
   *
   * @param e The click event
   */
  #editContent(e) {
    e.stopPropagation(); // we fully handle the click, so don't propagate

    // Only edit if not checked
    if (this.#check.checked) return;

    // Hide the display, show the input, and select all text
    this.#display.hidden = true;
    this.#input.hidden = false;
    this.#input.select();
  }

  /**
   * In response to the edit box losing focus, update the model and reset the
   * view
   */
  #saveContent() {
    // Update the display only if the model accepts the change
    if (TodoList.UpdateData(this.#id, this.#input.value))
      this.#display.innerHTML = this.#input.value;
    else this.#input.value = this.#display.innerHTML;
    // switch view visibility
    this.#input.hidden = true;
    this.#display.hidden = false;
  }

  /**
   * Handle clicks on the check box by toggling strikethrough and updating the
   * model
   */
  #toggleCheck(e) {
    e.stopPropagation();
    if (TodoList.UpdateCompleted(this.#id, e.target.checked)) {
      if (e.target.checked) this.#display.classList.add("strike-through");
      else this.#display.classList.remove("strike-through");
    }
  }

  /**
   * When a delete button is pressed, update the model and remove the element
   */
  #deleteTodoItem(e) {
    e.stopPropagation();
    if (TodoList.DeleteItem(this.#id)) this.parentNode.removeChild(this);
  }

  /** When a TodoItem tag is removed, remove its click listener */
  disconnectedCallback() {
    this.#check.removeEventListener("click", (e) => this.#toggleCheck(e));
  }
}
