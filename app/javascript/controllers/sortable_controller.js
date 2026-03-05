import { Controller } from "@hotwired/stimulus"
import Sortable from 'sortablejs'

// Connects to data-controller="sortable"
export default class extends Controller {
  connect() {
    document.querySelectorAll(".sortable-list").forEach(el => {
      Sortable.create(el, {
        group: "calendar",
        animation: 150,
        onEnd: async function (evt) {
          const dish = evt.item.dataset.dish_id;
          const category = evt.to.dataset.category;
          const newDay = evt.to.dataset.day_id;
          const newCategory = evt.to
          const previousCategory = evt.from
          console.log(previousCategory.children);
          if (previousCategory.children.length === 0) {
            previousCategory.innerHTML = `<div class="empty-meal">
              <span>No ${previousCategory.dataset.category} planned</span>
            </div>`
          }
          newCategory.querySelector(".empty-meal")?.remove()

          const formData = {
            dish: {day_id: newDay, category: category}
          }

          const url = `/dishes/${dish}`

          fetch(url, {
            method: "PATCH",
            headers:{
              'Content-Type': 'application/json',
              'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify(formData)
          });
        },
      });
    });
  }
}
