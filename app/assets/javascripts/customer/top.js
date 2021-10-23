document.addEventListener("turbolinks:load", function() {
  new HeroSlider();
});


class HeroSlider {
  constructor() {
    this.swiper = new Swiper('.swiper', {
      // Optional parameters
      // direction: 'vertical',
      loop: true,
      effect: 'coverflow',
      grabCursor: true,
      centeredSlides: true,
      slidesPerView: 1,
      speed: 1000,
      breakpoints: {
        1024: {
          slidesPerView: 2,
        }
      },
      autoplay: {
        delay: 4000,
        disableOnInteraction: false
      },
    //   // If we need pagination
    })
  }
}