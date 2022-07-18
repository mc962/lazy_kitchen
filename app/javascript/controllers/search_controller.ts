import { Controller } from "@hotwired/stimulus"
// import debounce from 'lodash.debounce'

// Connects to data-controller="search"
export default class extends Controller {
    private formTarget: HTMLFormElement;
    private inputTarget: HTMLInputElement;
    private submitTarget: HTMLInputElement;

    static targets = ['form', 'input', 'submit']
    private timeout: ReturnType<typeof setTimeout>;

    connect() { console.log("debounce controller connected") }

    autocomplete() {
        const currentQuery = this.inputTarget.value;
        if (currentQuery.length < 2) {
            // Only submit search field if query is at least 2 characters
            return;
        }

        clearTimeout(this.timeout)
        this.timeout = setTimeout(() => {
            this.formTarget.requestSubmit()
        }, 500)
    }

    send(event: Event) {
        event.preventDefault();
        console.log('Submitted!');
    }
  // private inputTarget: HTMLInputElement;
  // private submitTarget: HTMLInputElement;
  //
  // static targets = ['input', 'submit'];
  //
  // initialize() {
  //   // this.submit = debounce(
  //   //     this.submit,
  //   //     200,
  //   //     false
  //   // );
  // }
  //
  // connect() {
  //   // this.submitTarget.hidden = true;
  // }
  //
  // hideValidationMessage(event) {
  //   event.stopPropagation();
  //   event.preventDefault();
  // }
  //
  // submit() {
  //   const currentQuery = this.inputTarget.value;
  //
  //   if (currentQuery.length >= 2) {
  //     // Only submit search field if query is at least 2 characters
  //     this.submitTarget.click();
  //   }
  // }
}
