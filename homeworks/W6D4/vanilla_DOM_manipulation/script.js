document.addEventListener('DOMContentLoaded', () => {
  // toggling restaurants

  const toggleLi = e => {
    const li = e.target;
    if (li.className === 'visited') {
      li.className = '';
    } else {
      li.className = 'visited';
    }
  };

  document.querySelectorAll('#restaurants li').forEach(li => {
    li.addEventListener('click', toggleLi);
  });

  // adding SF places as list items

  // --- your code here!
  const handleSubmit = event => {
    event.preventDefault();

    // both ways are working
    const favoriteInput = document.getElementsByClassName('favorite-input')[0];
    // const favoriteInput = document.querySelector('.favorite-input');

    const favoriteValue = favoriteInput.value;
    favoriteInput.value = ''; // clear out the input

    const li = document.createElement('li');
    li.textContent = favoriteValue; // Create a new li with favoriteValue

    const SFplaces = document.getElementById('sf-places');
    SFplaces.appendChild(li); // Add to the favorite list
  };

  const submitButton = document.querySelector('.favorite-submit');
  submitButton.addEventListener('click', handleSubmit);

  // adding new photos

  const hanldeFormToggle = event => {
    const form = document.getElementsByClassName('photo-form-container')[0];

    form.className = form.className.includes('hidden')
      ? 'photo-form-container'
      : 'photo-form-container hidden';
  };

  const photoFormShowButton = document.querySelector('.photo-show-button');
  photoFormShowButton.addEventListener('click', hanldeFormToggle);

  // --- your code here!

  const handlePhotoSubmit = event => {
    event.preventDefault();

    const photoInput = document.querySelector('.photo-url-input');
    const photoValue = photoInput.value;
    photoInput.value = '';

    const li = document.createElement('li');
    const img = document.createElement('img');
    img.src = photoValue;
    li.appendChild(img);
    // console.log(li);

    const photoList = document.querySelector('.dog-photos');
    photoList.appendChild(li);
  };

  const photoSumbit = document.querySelector('.photo-url-submit');
  photoSumbit.addEventListener('click', handlePhotoSubmit);
});
