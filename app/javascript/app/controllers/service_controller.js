import { Controller } from "stimulus"


export default class extends Controller {
  static targets = ["array", "input", "publicContacts", "publicContact",
    "destroy", "addContact", "multimedia", "changelog", "grantProjectNames",
    "certifications", "standards", "openSourceTechnologies", "useCasesUrl",
    "relatedPlatforms"]

  initialize(){
  }

  addNewArrayField(event) {
    console.log(event)
    event.preventDefault()
    const lastArrayField = document.createElement("textarea")
    const parent_name = event.target.dataset.wrapper
    const parent = document.getElementsByClassName(parent_name)[0]

    lastArrayField.name = event.target.dataset.name
    lastArrayField.id = parent_name + "_" + (parent.children.length - 1)
    lastArrayField.classList = event.target.dataset.class

    parent.appendChild(lastArrayField)
  }

  _clearEmptyFields(target){
    for (let i = 0; i < target.childElementCount; i++) {
      var el = target.children[i]
      if(!el.value) {
        target.children[i].remove()
        i = i - 1
      }
    }
  }

  removeArrayField(event){
    const element = document.getElementById(event.target.dataset.name)
    element.parentNode.removeChild(element)
  }

  addContact(event){
    event.preventDefault();
    event.target.insertAdjacentHTML('beforebegin',
        event.target.dataset.fields.replace(/new_field/g, this.publicContactTargets.length));
  }

  removeContact(event){
    event.preventDefault();
    event.target.parentElement.previousElementSibling.value = "true";
    event.target.closest(".contact").classList.add("d-none");
  }

  onSubmit(event) {
    this._clearEmptyFields(this.multimediaTarget)
    this._clearEmptyFields(this.changelogTarget)
    this._clearEmptyFields(this.certificationsTarget)
    this._clearEmptyFields(this.standardsTarget)
    this._clearEmptyFields(this.openSourceTechnologiesTarget)
    this._clearEmptyFields(this.grantProjectNamesTarget)
    this._clearEmptyFields(this.useCasesUrlTarget)
    this._clearEmptyFields(this.relatedPlatformsTarget)
    this.element.submit();
  }
}
