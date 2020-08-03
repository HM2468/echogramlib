class HomepageController < ApplicationController
  def home
  end

  def pdf
    pdf_filename = File.join(Rails.root, "/public/user_manual.pdf")
    send_file(pdf_filename , :filename => "user_manual.pdf", :disposition => 'inline', :type => "application/pdf")
  end

end
