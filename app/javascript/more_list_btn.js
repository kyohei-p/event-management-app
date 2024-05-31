// もっとみるボタン
document.addEventListener('DOMContentLoaded', () => {
  // 表示するリストの数
  const moreNum = 5;

  const moreListBtn = document.querySelector('.more-list-btn-container');
  if(!moreListBtn) { return false; }
  moreListBtn.classList.remove('is-btn-hidden');


  const commentList = Array.from(document.querySelectorAll('.comment-list'));

  // 表示する数以降のリストを隠す
    if(commentList.length > moreNum) {
      commentList.slice(moreNum).forEach(list => {
      list.classList.add('is-hidden');
    })
  }

  // 「もっとみる」ボタンをクリックしたら、全てのリストを表示
  moreListBtn.addEventListener('click', () => {
    const hiddenList = document.querySelectorAll('.comment-list.is-hidden');
    hiddenList.forEach(list => {
      list.classList.remove('is-hidden');
    });

    moreListBtn.classList.add('is-btn-hidden');
    if(hiddenList.length == 0) {
      moreListBtn.style.display = 'none';
    }
  });

  // 全てのリストの数が、表示する数以下だった場合に「もっとみる」ボタンを非表示
  if(commentList.length <= moreNum) {
    moreListBtn.classList.add('is-btn-hidden');
  };
});