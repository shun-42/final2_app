import Raty from "raty-js"

document.addEventListener("turbo:load", () => {
  // --- 1. 投稿用 (idを使うので1つだけでOK) ---
  const postElem = document.querySelector("#post_raty");
  if (postElem) {
    postElem.innerHTML = "";
    new Raty(postElem, {
      scoreName: "book[score]",
      starOff: 'https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/images/star-off.png',
      starOn : 'https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/images/star-on.png',
    }).init();
  }

  // --- 2. 表示用 (querySelectorAllで全部取得してループさせる) ---
  const displayElems = document.querySelectorAll(".display-raty");
  if (displayElems.length > 0) { // 要素が1つ以上あれば実行
    displayElems.forEach((elem) => { // 1つずつ取り出して「elem」として処理
      elem.innerHTML = ""; // 2重表示防止
      const score = elem.getAttribute('data-score');
      new Raty(elem, {
        score: score,
        readOnly: true,
        starOff: 'https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/images/star-off.png',
        starOn : 'https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/images/star-on.png',
      }).init();
    });
  }
});