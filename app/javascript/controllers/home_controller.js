import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["skeleton", "games"]

  connect() {
    var input = document.querySelector('input[name=media]')
    new Tagify(input)

    addEventListener("turbo:submit-start", (event) => {
      this.gamesTarget.innerHTML = ""

      this.skeletonTargets.forEach((skeleton) => {
        skeleton.classList.remove("hidden")
      })
    })

    addEventListener("turbo:submit-end", (event) => {
      this.skeletonTargets.forEach((skeleton) => {
        skeleton.classList.add("hidden")
      })
    })
  }
}
