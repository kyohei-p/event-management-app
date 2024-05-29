//フラッシュメッセージを非同期で表示/非表示にする関数
function flashMessage(data) {
  const div = document.createElement('div');
  div.className = 'flash-message';
  div.textContent = data.message;

  const flashContainer = document.querySelector('.flash-message-container');
  flashContainer.appendChild(div);
  div.classList.add(data.message_type);

  flashContainer.style.position = 'fixed';
  flashContainer.style.top = '50%';
  flashContainer.style.left = '50%';
  flashContainer.style.opacity = 0.9;
  flashContainer.style.zIndex = 99;
  $(div).fadeOut(5000);
};

window.flashMessage = flashMessage;