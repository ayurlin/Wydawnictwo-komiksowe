// * Written by iawu Sept 2012.
// * Released under the MIT license
// * http://jquery.org/license

function closeElibriPreview(id) {
  setTimeout(function() {
    jQuery('#elibri_' + id).remove();
    jQuery('html').css({'overflow': 'auto'});
  }, 100);
}

function showElibriPreview(id) {
    jQuery('html').css({'overflow': 'hidden'});
    jQuery('#elibri_' + id).css('top', jQuery( document ).scrollTop()).fadeIn(500);
}

function runElibriPreview(id, iframe_url) {
    var res = function(a,b,c){function w(a,b){return!!~(""+a).indexOf(b)}function v(a,b){return typeof a===b}function u(a,b){return t(prefixes.join(a+";")+(b||""))}function t(a){j.cssText=a}var d="2.0.6",e={},f=b.documentElement,g=b.head||b.getElementsByTagName("head")[0],h="modernizr",i=b.createElement(h),j=i.style,k,l=Object.prototype.toString,m={},n={},o={},p=[],q,r={}.hasOwnProperty,s;!v(r,c)&&!v(r.call,c)?s=function(a,b){return r.call(a,b)}:s=function(a,b){return b in a&&v(a.constructor.prototype[b],c)},m.canvas=function(){var a=b.createElement("canvas");return!!a.getContext&&!!a.getContext("2d")};for(var x in m)s(m,x)&&(q=x.toLowerCase(),e[q]=m[x](),p.push((e[q]?"":"no-")+q));t(""),i=k=null,e._version=d;return e}(this,this.document);

  if (res['canvas']) {

    var $frame = jQuery('<iframe />').prop('id', 'elibri_' + id)
      .css( {
        'background': 'none',
        'position': 'absolute',
        'width' : '100%',
        'height' : '100%',
        'top': '0',
        'left': '0',
        'z-index' : '100000'
      }).hide().prop('src', iframe_url).appendTo(document.body);

  } else {
    alert('Ta funkcja nie działa gdyż masz włączony tryb zgodności lub używasz nieaktualnej przeglądarki');
  }
}

$(function() {
  $(document).on("click", "a.book-preview", function(e) {
     e.preventDefault();
     var id = $(this).data('id');
     var path = $(this).data('path');
     runElibriPreview(id, path);
  });
});

