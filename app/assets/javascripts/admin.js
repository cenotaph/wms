//= require usb-nfc
//= require jquery_nested_form

function linkCard() {
  var usbNfcLink = new UsbNFC();
  usbNfcLink.readTag(function (tagResp) {
    if (tagResp.id) {
      if (tagResp.id == "(null)") {
        linkCard();
      } else {
        $('#nfc_tag_address').val(tagResp.id);
      }
    } else {
      linkCard();
    }
  });
}
