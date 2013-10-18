class UserMailer < ActionMailer::Base

	default from: 'doctorrrrrrr@gmail.com'
	
	def welcome_email(user)
		@user = user
		@url = 'http://xtc.co.id'
		@site_name = 'XTC'
		mail(	to: @user.email,
				subject: 'Selamat datang di XTC')
	end
end
