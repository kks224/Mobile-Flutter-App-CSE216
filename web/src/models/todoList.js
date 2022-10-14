/**
 * TodoList is the data model.  It defines the primary data structure used by
 * our application.
 *
 * Note that since we are using JavaScript, there is no type information here.
 * We can inspect the code and figure out that the data model consists of an
 * array of objects, where each object has three fields:
 *
 * - id: a unique identifier for this object.  Note that it cannot simply be the
 *   index of the element in the array, because we want to be able to delete
 *   elements.
 * - data: the data associated with this object.  This is just text, but since
 *   we will put it into an HTML element, it's legal to put HTML tags in the
 *   text.  That can be dangerous. You might not want to do that!.
 * - complete: a boolean to indicate if the item is completed or not
 *
 * Note, too, that TodoList consists of static fields and a bunch of static
 * methods.  This means it is something of a singleton pattern, albeit without
 * any nice language mechanisms to enforce protection.
 */
export class TodoList {
  /** The array of {id, data, complete} tuples */
  static #State = [];

  /** A strictly monotomically increasing counter, for Ids */
  static #IdGenerator = 0;

  /**
   * Add a new item to the Todo List by providing its id, data, and completion
   * status
   */
  static CreateItem() {
    let id = this.#IdGenerator++;
    let complete = false;
    let data = "Task " + id;
    // Note this syntax: we don't have to say `{id : id, data: data,
    // complete: complete}`, because the variable names for the content of
    // each field match the field names.
    let res = { id, data, complete };
    this.#State.push(res);
    return res;
  }

  /** Get and return the item from the todo list with matching `id` */
  static ReadItem(id) {
    return this.#State.find((t) => t.id == id);
  }

  /** Overwrite the data for the Todo List item whose id matches `id` */
  static UpdateData(id, data) {
    if (!data) return false; // reject if the data would become empty
    let todoItem = this.#State.find((t) => t.id == id);
    if (!todoItem) return false;
    todoItem.data = data;
    return true;
  }

  /** Set the 'completed' state of the item whose id matches `id` */
  static UpdateCompleted(id, completed) {
    let todoItem = this.#State.find((t) => t.id == id);
    if (!todoItem) return false;
    todoItem.completed = completed;
    return true;
  }

  /** Remove the Todo List item whose id matches `id` */
  static DeleteItem(id) {
    let s = this.#State.length;
    this.#State = this.#State.filter((t) => t.id != id);
    return this.#State.length == s - 1;
  }
}
