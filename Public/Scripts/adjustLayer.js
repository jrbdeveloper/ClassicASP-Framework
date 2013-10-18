// adjustLayer.js
// X v3.10, Cross-Browser DHTML Library from Cross-Browser.com
// Copyright (c) 2002,2003 Michael Foster (mike@cross-browser.com)
// This library is distributed under the terms of the LGPL (gnu.org)

// Variables:
function adjustLayout()
{
  // Get natural heights
  var cHeight = xHeight("contentcontent");
  var lHeight = xHeight("leftcontent");
  var rHeight = xHeight("rightcontent");

  // Find the maximum height
  var maxHeight =
    Math.max(cHeight, Math.max(lHeight, rHeight));

  // Assign maximum height to all columns
  xHeight("content", maxHeight);
  xHeight("sidebar", maxHeight);
  xHeight("sidebarLogin", maxHeight);

  // Show the footer
  xShow("footer");
}

window.onload = function()
{
  xAddEventListener(window, "resize",
    adjustLayout, false);
  adjustLayout();
}
// end adjustLayer.js





