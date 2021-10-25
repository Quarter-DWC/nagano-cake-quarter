document.addEventListener("turbolinks:load", function() {
  if (location.pathname.match("admin")) {
    return;
  } else {
    new SearchActive();
  }
});

class SearchActive {
  constructor() {
    this.search_btn = document.querySelector(".search_btn");
    this.search_area = document.querySelector("#search_area");
    this.eventType = this._getEventType();
    this._addEvent();
  }

  _getEventType() {
    return window.onclick = 'click';
  }

  _toggle() {
    this.search_area.classList.toggle('active');
  }

  _addEvent() {
    this.search_btn.addEventListener(this.eventType, this._toggle.bind(this));
  }
}