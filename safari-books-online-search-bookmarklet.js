/******************************************************************************
This is a bookmarklet that can be used on the Safari Books Online search screen
to select every publisher except Packt Publishing.

To install, copy everything after this header into a new bookmark in your
browser.  Then on the Safari Books Online search screen, select the bookmark,
wait, and all publishers (as of the last modification of this script) will be
selected except Packt Publishing (as new publishers are added to Safari
Books Online they will also need to be added to this script).

Tested in Firefox and Edge.

A Huge Thank You to https://mrcoles.com/bookmarklet/ ,
which this bookmarklet relies heavily on and would not be possible without.
******************************************************************************/

javascript: (function() {
  let publishersBlock = document.querySelector('div[data-testid="publishers"]');
  let publishersSearchInput = publishersBlock.querySelector('input[type="search"]');
  let publishersToggle = publishersBlock.querySelector('button[data-testid="publishers-toggle"]');
  if (!publishersSearchInput) {
    publishersToggle.click();
  }
  setTimeout(() => {
    Array.from(publishersBlock.querySelectorAll('input[type="checkbox"]'))
      .filter(e => !e.checked)
      .filter(e => !e.id.startsWith("publishers-packt-publishing-"))
      .forEach(e => e.click());
    publishersToggle.click();
  }, 100);
})()
