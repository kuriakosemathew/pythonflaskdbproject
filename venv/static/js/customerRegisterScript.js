

$(function(){
	$.validator.setDefaults({
		highlight: function(element){
			$(element)
			.closest('.form-group')
			.addClass('has-error')
		},
		unhighlight: function(element){
			$(element)
			.closest('.form-group')
			.removeClass('has-error')
		}
	});

	//$(document).ready(function() {
   $("#registerForm").validate({
       rules:
            {
                firstName: "required",
                lastName: "required",
                password: "required",
                address: "required",
                country: "required",
                city: {
                    required: true
                },
                phoneNumber: {
                    required: true,
                    number: true
                },
                email: {
                    required: true,
                    email: true
                }
            },
         messages: {
            email: {
                required: true,
                email: true
            },
        password: {
            required: " Please enter password"
        },
        birthDate: {
            required: " Please enter birthdate"
        },
        email: {
            required: ' Please enter email',
            email: ' Please enter valid email'
        },
        weight: {
            required: " Please enter your weight",
            number: " Only numbers allowed"
        },
        height: {
            required: " Please enter your height",
            number: " Only numbers allowed"
        }
        }
   });
});
