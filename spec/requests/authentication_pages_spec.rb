require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe "signin form" do
		before { visit root_path }

		it { should have_selector('h2', text: 'Silahkan masuk') }
  	end

  	describe "signin" do
  		before { visit root_path }

  		describe "with invalid information" do
  			before { click_button "Masuk" }
  			it { should have_selector('div.alert.alert-error', text: 'Invalid') }

  			describe "after visiting another page" do
  				before { click_link "XTC" }
  				it { should_not have_selector('div.alert.alert-error') }
  			end
    	end

    	describe "with valid information" do
    		let(:user) { FactoryGirl.create(:user) }
    		before do
    			fill_in "Alamat email",    with: user.email.upcase
    			fill_in "Sandi", with: user.password
        		click_button "Masuk"
      		end

      		it { should have_title(user.name) }
      		it { should have_link('Profile',     href: user_path(user)) }
      		it { should have_link('Sign out',    href: signout_path) }
      		it { should_not have_link('Sign in', href: signin_path) }
    	end
  	end
end