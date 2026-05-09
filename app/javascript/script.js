import Raty from "raty-js";

document.addEventListener("turbo:load", () => {
  const elements = document.querySelectorAll(".raty-display");

  elements.forEach((elem) => {
    new Raty(elem, {
      readOnly: true,
      score: elem.dataset.score,
      starOn: "/assets/star-on.png",
      starOff: "/assets/star-off.png",
    }).init();
  });
});