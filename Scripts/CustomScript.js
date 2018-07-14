$(document).ready(function () {
   
//    $('.sfHover >ul > li > a').hover
//    (

//  function () { console.log('apply black color'); $(this).css('color', 'black'); },

//  function () { console.log('apply white color'); $(this).css('color', 'white'); }


    //  );

    $('.sfHover ul li a').hover(function () { $('a', this).css('color', 'black'); }, function () { $('a', this).css('color', 'white'); });

   

});




var d = document;
var safari = (navigator.userAgent.toLowerCase().indexOf('safari') != -1) ? true : false;
var gebtn = function (parEl, child) { return parEl.getElementsByTagName(child); };
onload = function () {

    var body = gebtn(d, 'body')[0];
    body.className = body.className && body.className != '' ? body.className + ' has-js' : 'has-js';

    if (!d.getElementById || !d.createTextNode) return;
    var ls = gebtn(d, 'label');
    for (var i = 0; i < ls.length; i++) {
        var l = ls[i];
        if (l.className.indexOf('label_') == -1) continue;
        var inp = gebtn(l, 'input')[0];
        if (l.className == 'label_check') {
            l.className = (safari && inp.checked == true || inp.checked) ? 'label_check c_on' : 'label_check c_off';
            l.onclick = check_it;
        };
        if (l.className == 'label_radio') {
            l.className = (safari && inp.checked == true || inp.checked) ? 'label_radio r_on' : 'label_radio r_off';
            l.onclick = turn_radio;
        };
    };
};
var check_it = function () {
    var inp = gebtn(this, 'input')[0];
    if (this.className == 'label_check c_off' || (!safari && inp.checked)) {
        this.className = 'label_check c_on';
        if (safari) inp.click();
    } else {
        this.className = 'label_check c_off';
        if (safari) inp.click();
    };
};
var turn_radio = function () {
    var inp = gebtn(this, 'input')[0];
    if (this.className == 'label_radio r_off' || inp.checked) {
        var ls = gebtn(this.parentNode, 'label');
        for (var i = 0; i < ls.length; i++) {
            var l = ls[i];
            if (l.className.indexOf('label_radio') == -1) continue;
            l.className = 'label_radio r_off';
        };
        this.className = 'label_radio r_on';
        if (safari) inp.click();
    } else {
        this.className = 'label_radio r_off';
        if (safari) inp.click();
    };
};



	function displayError(pCustomAlert) {
		$(function () {
				$('#diaMsg').text(pCustomAlert);
				 $("#dialog-message").dialog({
					 dialogClass: "alertError",
					 modal: true,
					 resizable: false,
					 buttons: {
						 Ok: function () {
							 $(this).dialog("close");
						 }
					 }
				 });
			 });
	}

	function displayAlert(pCustomAlert) {
		$(function () {
				$('#diaMsg').text(pCustomAlert);
				 $("#dialog-message").dialog({
					 modal: true,
					 resizable: false,
					 buttons: {
						 Ok: function () {
							 $(this).dialog("close");
						 }
					 }
				 });
			 });
	}

	function displayAlert(pCustomAlert, funcName) {
		$(function () {
				$('#diaMsg').text(pCustomAlert);
				 $("#dialog-message").dialog({
					 modal: true,
					 resizable: false,
					 buttons: {
						 Ok: function () {
							 $(this).dialog("close");
							 eval(funcName)();
							 //getCourseList();
						 }
					 }
				 });
			 });
	}

	function goHome() {
		location.href='Home.jsp';
	}

	function goAdmissionReport() {
		location.href='AdmissionReport.jsp';
	}

	function dummy() {

	}
	function doLogin() {
		location.href='Login.jsp';
	}
	function StopLoading()
	{
		$('#divLoading').hide();
	}
	function centerDiv(id) {
		var winH = $('#tabs-2').height();
		var winW = $('#tabs-2').width();

		var dialog = $(id);

		var maxheight = dialog.css("max-height");
		var maxwidth = dialog.css("max-width");

		var dialogheight = dialog.height();
		var dialogwidth = dialog.width();

		if (maxheight != "none") {
			dialogheight = Number(maxheight.replace("px", ""));
		}
		if (maxwidth != "none") {
			dialogwidth = Number(maxwidth.replace("px", ""));
		}
		dialog.css('width',winW + 'px');
		dialog.css('height',winH + 'px');
		dialog.css('top', 0);
		dialog.css('left', 0);
		dialog.children('img').css('top', winH / 2 - dialogheight / 2);
		dialog.children('img').css('left', winW / 2 - dialogwidth / 2);
		
		//dialog.css('top', winH / 2 - dialogheight / 2);
		//dialog.css('left', winW / 2 - dialogwidth / 2);
	}

/****************superfish fix**************/

function validateFileExtension(component, extns)
{
with(component)
{
var ext=value.substring(value.toLowerCase().lastIndexOf('.') + 1);
if(extns.indexOf(ext.toLowerCase()) == -1) {
	displayAlert("File format should be "+extns);
	return false;
}
else
{
	return true;
}
} 
}
