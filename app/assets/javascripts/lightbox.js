//lightbox dla komiksów i okładek
$(function() {
  $(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) { 
    event.preventDefault(); 
    $(this).ekkoLightbox({loadingMessage: "Ładuję grafikę...", gallery: "product", always_show_close: true}); 
  });
});
