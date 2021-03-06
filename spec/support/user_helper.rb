module UsersHelper

	def sign_in user, password='password'
		visit new_user_session_path
		fill_in	'Email', :with => user.email
		fill_in	'Password', :with => 'password'
		click_button 'Sign in'
	end

	def admin_sign_in admin, password='password'
		visit new_admin_session_path
		fill_in	'Email', :with => admin.email
		fill_in	'Password', :with => 'password'
		click_button 'Sign in'
	end

	def sign_up email, password, password_confirmation
		visit new_user_registration_path
		fill_in 'Email', with: email
		fill_in 'Password', with: password
		fill_in 'Password confirmation', with: password_confirmation
		click_button 'Sign up'
	end
end
