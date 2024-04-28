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
  function callback() {
    (function($) {
      /********* START MY CODE **********/
      let publisherBtn = $('button:contains("Publishers")')
                          .filter(function() {return $(this).text() === "Publishers"});
      publisherBtn.click();
      let publisherSearchDiv = publisherBtn.parent();
      setTimeout(() => {
        publisherSearchDiv.find("input[type='checkbox']")
                          .filter(':not(:checked)')
                          .filter((i,e) => e.name !== "Packt Publishing")
                          .each((i,e) => { console.log("Checking " + e.name);  } )
                          .next() /* Only clicking on the label works for some reason?? */
                          .click();
        publisherSearchDiv.find('button:contains("Apply")').click();
      }, 100);
      /********* END MY CODE **********/
    })(jQuery.noConflict(true));
  }
  let s = document.createElement("script");
  s.src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js";
  if (s.addEventListener) {
    s.addEventListener("load",callback,false);
  } else if (s.readyState) {
    s.onreadystatechange=callback;
  }
  document.body.appendChild(s); 
})()
