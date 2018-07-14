$(function() {
	/*
	number of fieldsets
	*/
	var fieldsetCount = $('#formElem').children().length;
	
	/*
	current position of fieldset / navigation link
	*/
	var current 	= 1;
    
	/*
	sum and save the widths of each one of the fieldsets
	set the final sum as the total width of the steps element
	*/
	var stepsWidth	= 0;
    var widths 		= new Array();
	$('#steps .step').each(function(i){
        var $step 		= $(this);
		widths[i]  		= stepsWidth;
        stepsWidth	 	+= $step.width();
    });
	$('#steps').width(stepsWidth);
	
	/*
	to avoid problems in IE, focus the first input of the form
	*/
	$('#formElem').children(':first').find(':input:first').focus();	
	
	/*
	show the navigation bar
	*/
	$('#navigation').show();
	
	/*
	when clicking on a navigation link 
	the form slides to the corresponding fieldset
	*/
    $('#navigation a').bind('click',function(e){
		var $this	= $(this);
		var prev	= current;
		$this.closest('ul').find('li').removeClass('selected');
        $this.parent().addClass('selected');
		/*
		we store the position of the link
		in the current variable	
		*/
		current = $this.parent().index() + 1;
		/*
		animate / slide to the next or to the corresponding
		fieldset. The order of the links in the navigation
		is the order of the fieldsets.
		Also, after sliding, we trigger the focus on the first 
		input element of the new fieldset
		If we clicked on the last link (confirmation), then we validate
		all the fieldsets, otherwise we validate the previous one
		before the form slided
		*/
        $('#steps').stop().animate({
            marginLeft: '-' + widths[current-1] + 'px'
        },500,function(){
			if(current == fieldsetCount)
				validateSteps();
			else
				validateStep(prev);
			$('#formElem').children(':nth-child('+ parseInt(current) +')').find(':input:first').focus();	
		});
        e.preventDefault();
    });
	
	/*
	clicking on the tab (on the last input of each fieldset), makes the form
	slide to the next step
	

	$('#formElem > fieldset').each(function(){
		var $fieldset = $(this);
		//alert($fieldset.children(':last').find(':input').attr("id"));
		$fieldset.children(':last').find(':input').keydown(function(e){
			//alert(e.which);
			if (e.which == 9){
				$('#navigation li:nth-child(' + (parseInt(current)+1) + ') a').click();
				$(this).blur();
				e.preventDefault();
			}
		});
	});															
*/
		$("select[id=parent_occupation]").keydown(function(event){     
			if(event.keyCode == 9){      
				$('#navigation li:nth-child(' + (parseInt(current)+1) + ') a').click();
				event.preventDefault();
			}
		});

		$("input[id=transport_reqd]").keydown(function(event){     
			if(event.keyCode == 9){      
				$('#navigation li:nth-child(' + (parseInt(current)+1) + ') a').click();
				event.preventDefault();
			}
		});



	/*
	validates errors on all the fieldsets
	records if the Form has errors in $('#formElem').data()
	*/
	function validateSteps(){
		var FormErrors = false;
		for(var i = 1; i < fieldsetCount; ++i){
			var error = validateStep(i);
			if(error == -1)
				FormErrors = true;
		}
		$('#formElem').data('errors',FormErrors);	
	}
	
	/*
	validates one fieldset
	and returns -1 if errors found, or 1 if not
	*/
	function validateStep(step){
		if(step == fieldsetCount) return;
		//not('input[type=radio]')
		var error = 1;
		var hasError = false;
		var fs=$('#formElem').children(':nth-child('+ parseInt(step) +')');
		fs.find('input').not(':button').not('classnm').each(function(){
			var $this 		= $(this);
			//alert($(this).hasClass("nm"));
			var valueLength = jQuery.trim($this.val()).length;
			if( ! $(this).hasClass("nm")) {
				if(valueLength == ''){
					hasError = true;
					$this.css('background-color','#FFEDEF');
				}
				else
					$this.css('background-color','#FFFFFF');	
			}
		});
		
		fs.find('select').each(function(){
			var $this 		= $(this);
			if($this.val()=="") {
				hasError = true;
				$this.css('background-color','#FFEDEF');
			}
			else
				$this.css('background-color','#FFFFFF');	
		});

		fs.find('input[type=radio]').each(function(){
			var $this = $(this);

		if(!$("input[@name=$this.attr(\"id\") ]:checked").val()) {
			//if($this.val()=="") {
				hasError = true;
				$this.css('background-color','#FFEDEF');
			}
			else
				$this.css('background-color','#4797ED');	
		});


		//alert(hasError);
		var $link = $('#navigation li:nth-child(' + parseInt(step) + ') a');
		$link.parent().find('.error,.checked').remove();
		
		var valclass = 'checked';
		if(hasError){
			error = -1;
			valclass = 'error';
		}
		$('<span class="'+valclass+'"></span>').insertAfter($link);
		
		return error;
	}
	
	/*
	if there are errors don't allow the user to submit

	$('#registerButton').bind('click',function(){
		if($('#formElem').data('errors')){
			alert('Please correct the errors in the Form');
			return false;
		}	
	});
	*/
	
});