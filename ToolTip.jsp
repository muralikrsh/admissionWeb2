<script type="text/javascript">
 $(document).ready(function () {
	 $(function () {
		 $('#maintab input[type="text"]').tooltip({
			 track: true,
			 position: {
				 my: "center bottom-20",
				 at: "center top",
				 using: function (position, feedback) {
					 $(this).css(position);
					 $("<div>")
	.addClass("arrow")
	.addClass(feedback.vertical)
	.addClass(feedback.horizontal)
	.appendTo(this);
				 }
			 }
		 });
	 });
	jQuery(document).ready(function () {
		jQuery('ul.sf-menu').superfish();
		//$("#tabs").tabs();
	});
 });


</script>
