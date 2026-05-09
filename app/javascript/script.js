document.addEventListener("turbo:load", () => {
  const elem = document.querySelector("#post_raty");
  if (!elem) return;

  new Raty(elem, {
    scoreName: "book[score]",
    starOff: 'https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/images/star-off.png',
    starOn: 'https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/images/star-on.png',
  }).init();
});