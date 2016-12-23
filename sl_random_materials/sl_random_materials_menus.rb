=begin
Copyright 2017 Sean Lin
All Rights Reserved

Disclaimer
THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED 
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'sketchup.rb'
require 'sl_random_materials/sl_random_materials_data.rb'

# Change this to your own personal name space. SU_Extensions_template is a 
# SketchUp namespace, used only for this template example.  
# Please do not use it. Use something UNIQUE and use it on all your plugins.
module SL_Random_Materials

  # Change this to your own script's namespace. Notice that this 
  # resides in the SU_Extensions_template namespace, so it will 
  # not clash with other developer's scripts.
	module Random_Materials 
		
		# This section loads the extension into the menu system. The 
    # file_loaded? method is from the sketchup.rb file. It checks to see if
    # a file has already been loaded.  This is to help prevent double loading
    # of a script into the menu system, especially during development.
		if !file_loaded?(__FILE__)

      # Add a submenu to the "Plugins" menu.
      sl_random_materials_menu = UI.menu("Extensions").add_separator
      # Create the toolbar object we will be using
      tb = UI::Toolbar.new("EW Template")
      	
			# See the SU Ruby API docs for more information on creating
      # toolbars and menu commands.
      command = UI::Command.new("SL Randomly Assign Materials")
      command.tooltip = "Randomly assign materials by assigned propotion"
      command.status_bar_text = "Select faces with materials to be assigned"
      command.menu_text = "SL Randomly Assign Materials"
      sl_random_materials_menu.add_item(command)
      
      # This tells SU that the file is loaded into the menu system
			file_loaded(__FILE__)
		end
		
	end #module
  
end #module

