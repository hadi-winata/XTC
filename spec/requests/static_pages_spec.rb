require 'spec_helper'

describe "Static pages" do

	subject {page}

	shared_examples_for "all static pages" do
		it { should have_selector('h1', text: heading) }
		it { should have_title(full_title(page_title)) }
	end

	describe "Home page" do
		before { visit root_path }

		it { should have_content('') }
    	it { should have_title(full_title('')) }
		it {should_not have_title('| Beranda')}
	end

	describe "Help page" do
		before {visit help_path}

		it {should have_content('Tolong')}
		it {should have_title(full_title('Tolong'))}
	end

	describe "Contact page" do
		before {visit contact_path}

		it {should have_content('Kontak')}
		it {should have_title(full_title('Kontak'))}
	end

	describe "About page" do
		before {visit about_path}

		it {should have_content('Tentang')}
		it {should have_title(full_title('Tentang'))}
	end
end
