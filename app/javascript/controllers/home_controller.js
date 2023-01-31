import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["skeleton", "games", "media"]

  connect() {
    new Tagify(this.mediaTarget, {
      delimiters: ";",
      originalInputValueFormat: valuesArr => valuesArr.map(item => item.value).join(',')
    })

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
