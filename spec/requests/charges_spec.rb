require 'spec_helper'

describe 'charges' do
	let!(:item) { FactoryGirl.create(:item) }
	let!(:user) { FactoryGirl.create(:user) }
	let!(:address) { FactoryGirl.create(:address, user: user, current_address: true) }

	describe 'new' do
		before do
			visit root_path
			within '.edit_basket' do
				click_button 'Add item to basket'
			end
		end

		context 'when not signed in' do
			it 'should redirect user to the sign in page' do
				click_link 'Checkout'

				expect(page.current_path).to eq new_user_session_path
				expect(page).to have_content 'Please sign in to continue'
			end
		end

		context 'when signed in' do
			before { sign_in user }
			it 'should not redirect you to the sign in page' do
				click_link 'Checkout'

				expect(page).to_not have_content 'Please sign in to continue'
				expect(page.current_path).to eq new_charge_path
			end
		end

		describe 'checking out' do
			let!(:item2) { 2.times{ FactoryGirl.create(:item) } }
			before { sign_in user }

			it 'should redirect you to checkout page' do
				page.all(:css, '.edit_basket')[1].click_button 'Add item to basket'
				click_link 'Checkout'

				expect(page).to have_content 'Please confirm your details'
				expect(page).to have_content 'Address'
				expect(page).to have_content 'Email'
			end

			it 'should display the sub total of your basket' do
				click_link 'Checkout'
				
				# raise page.html
				within '.amount' do
					expect(page).to have_content 'Sub total: £2.00'
				end
			end
		end

	end

	after do
  	FactoryGirl.reload
	end
end

	# describe 'payment' do

	# 	before do
	# 		visit root_path
	# 		click_button 'Add item to basket'
	# 		sign_in user
	# 	end

	# 	context 'success' do

	# 		it 'should indicate success', js: true do

	# 			click_link 'Checkout'

	# 			click_button 'Pay with Card'

	# 			sleep 2

	# 			within_frame '__stripe-checkout-remote-variant-frame' do
	# 				sleep 5
	# 				raise page.html
					# within '.payment' do
					# 	fill_in 'Card number', with: '4242424242424242'
					# 	fill_in 'Expires', with: '04/2014'
					# 	fill_in 'Name on card', with: 'MR CHEWY'
					# 	fill_in 'Card code', with: '345'
					# 	click_button "Pay £5.00"
					# end
		# 		end

		# 		expect(page).to have_content 'Thanks, you paid £5.00!'
		# 		expect(page).to_not have_content 'checkout'
		# 		expect(page).to have_content '0 items'
		# 	end
		# end

		# context 'failure' do

		# 	before do
		# 		click_link 'Checkout'
		# 		click_link 'Pay with Card'
		# 	end

		# 	describe 'with an incorrect cvc number' do
		# 		it 'should indicate failure' do
		# 			fill_in 'Card number', with: '4000000000000127'
		# 			fill_in 'Expires', with: '04/2014'
		# 			fill_in 'Name on card', with: 'MR CHEWY'
		# 			fill_in 'Card code', with: '345'
		# 			click_button "Pay £5.00"

		# 			expect(page).to have_content "Your card's security code is incorrect."
		# 		end
		# 	end
		# end
	# end
# end