$(document).ready(function(){
	$("#signUpForm").on("submit",function(event){
		event.preventDefault();
		$form = $(event.target)
		$formSubmit =$form.find('input[id="signUpButton"]')
		@formSubmit.val('Loading...')
		$.ajax({
			url: $form.attr('action'),
			method: $form.attr('method'),
			data: $form.serialize(),
			dataType:"JSON",
			success:function(response)
			debugger:

		});
	});

});

$(document).ready(function(){
	console.log("JQuery Ready!");

	$("#like_button").on("submit",function(event){

		event.preventDefault();


		$.ajax({

			url: '/answers/:id/votes',
			method: 'post',
			data: $form.serialize(),
			dataType: 'JSON'
			success: function (response) {
			
			}
		});


	});
});




$(document).ready(function(){

	$("#shorten").submit(function(event){
		
		event.preventDefault();
		
		var $form = $(event.target)
		// set button to show loading message
		$form.find('.input_link_shorten').val('Loading...')

		$.ajax({	
			url: '/submit',
			method: 'post',
			data: $form.serialize(), // get data
			success: function(response){

				// turn string to JSON object
				// "{"saved":true,"result":"b007b1"}" => object
				response = JSON.parse(response)
				if(response.saved) {					
					$('#result').text('Your short url is localhost:9393/' + response.result)
				} else {
					$('#result').text('URL is invalid. Please try again')
				}

				$form.find('.input_link_shorten').val('SHORTEN')

				// if-else
				// add message to #result
			}
		})		
	})

});