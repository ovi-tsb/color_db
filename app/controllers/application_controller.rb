class ApplicationController < ActionController::Base


  def after_sign_in_path_for(resource)
    
    inks_path # or any other path needed
   
  end

  def after_update_path_for(resource)
    inks_path
  end
  
end
