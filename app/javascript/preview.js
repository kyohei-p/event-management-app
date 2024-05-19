document.addEventListener('DOMContentLoaded', () => {

  const fileInput = document.getElementById('image-upload');
  const imagePreview = document.getElementById('image-preview') || document.getElementById('event-image-preview');
  const deleteImageField = document.getElementById('delete_image_field');

  imagePreview.addEventListener('click', () => {
    fileInput.click();
  });

  fileInput.addEventListener('change', (e) => {
    const file = e.target.files[0];

    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        imagePreview.src = e.target.result;
        deleteImageField.checked = false;
      };
      reader.readAsDataURL(file);
    }
  });
});