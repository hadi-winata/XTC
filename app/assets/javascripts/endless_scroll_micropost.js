var currentPage = 1;
var intervalID = -1000;

function checkScroll() {
  if (nearBottomOfPage()) {
    currentPage++;
  console.log("endless request "+ currentPage);
    jQuery.ajax('?page=' + currentPage, {asynchronous:true, evalScripts:true, method:'get', success: function(data, textStatus, jqXHR) {
		$('.micropost').append(jQuery(data).find('.micropost').html());
		if(typeof jQuery(data).find('.micropost').html() == 'undefined' || jQuery(data).find('.micropost').html().trim().length == 0){
			clearInterval(intervalID);
		}
	},});
  }
}

function nearBottomOfPage() {
  return scrollDistanceFromBottom() < 50;
}

function scrollDistanceFromBottom(argument) {
  return pageHeight() - (window.pageYOffset + self.innerHeight);
}

function pageHeight() {
  return Math.max(document.body.scrollHeight, document.body.offsetHeight);
}

$('document').ready(function(){
	intervalID = setInterval(checkScroll, 250);
})