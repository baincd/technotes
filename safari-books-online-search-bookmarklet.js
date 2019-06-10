/******************************************************************************
This is a bookmarklet that can be used on the Safari Books Online search screen
to select every publisher except Packt Publishing.

To install, copy everything after this header into a new bookmark in your
browser.  Then on the Safari Books Online search screen, select the bookmark,
wait, and all publishers (as of the last modification of this script) will be
selected except Packt Publishing (as new publishers are added to Safari
Books Online they will also need to be added to this script).

Tested in Firefox and Chrome.

A Huge Thank You to https://mrcoles.com/bookmarklet/ ,
which this bookmarklet relies heavily on and would not be possible without.
******************************************************************************/

javascript:
(function() {
  function callback() {
    (function($) {
      var jQuery=$;
      /********* START MY CODE **********/
      var publisherBtn = $(':contains("publishers")')
                            .filter(function() {return $(this).text() === "publishers"})
                            .parent()
                            .parent();

      var publisherSearchDiv = publisherBtn.parent();

      publisherSearchDiv.find('input[type="checkbox"]')
                        .filter(':not(:checked)')
                        .filter(function() {return $(this).val() !== "all" && $(this).val() !== "Packt Publishing"})
                        .click();

      publisherBtn.click();

      publisherSearchDiv.find(':contains("View")')
                .filter(function() {return $(this).text().includes("results")})
                .parent()
                .click();
      /********* END MY CODE **********/
    })
    (jQuery.noConflict(true))
  }
  var s = document.createElement("script");
  s.src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js";
  if (s.addEventListener) {
    s.addEventListener("load",callback,false)
  } else if (s.readyState) {
    s.onreadystatechange=callback
  }
  document.body.appendChild(s);
})()
