=begin
Copyright 2017 Sean Lin
All Rights Reserved
Script Name:
sl_random_materials.rbz
Description:
This a Sketchup Ruby script to randomly assign selected materials
to selected faces with designated propotion.
Usage:
Access the extension from the menu "Entensions > SL Random Materials".
History:
1.0 - 2017-1-01
   * First release
Disclaimer:
THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED 
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
=end


# The whole thing is wrapped in a SU_Extensions module
# Developers should wrap their extensions inside their own modules.
module SLin # <--Change this to your own personal name space

	# This entire script is wrapped inside its own module,
  # inside of our SU_Extensions module.
	module Random_Materials # <--Change this to your own scripts name space

		# Common required files for creating extensions
		require 'sketchup.rb'
		require 'extensions.rb'
		require 'langhandler.rb'


		# The "new" method is used to create a new SketchupExtension object. 
		# Note that once the extension object is created, it will not appear in 
    # the Extension Manager dialog until your register it with the 
    # Sketchup.register_extension method.
		sl_random_materials = SketchupExtension.new( 
      "SL Random Materials", 
      "sl_random_materials/sl_random_materials_core.rb")


		# The "name=" method sets the name which appears for an 
    # extension inside the Extensions Manager dialog.
		sl_random_materials.name = "SL Random Materials"


		# The "description=" method sets the long description which appears 
    # beneath an extension inside the Extensions Manager dialog.
		sl_random_materials.description = "This extension randomly assigns " +
    "selected materials to faces with designated propotion"


		# The "version" method sets the version which appears beneath an extension
    # inside the Extensions Manager dialog.  This is recommended to be a 
    # major.minor.revision versioning scheme.
		sl_random_materials.version = '1.0.0'


		# The "copyright=" method sets the copyright string which appears 
    # beneath an extension inside the Extensions Manager dialog.
		sl_random_materials.copyright = "2017"
		 
		 
		# The "creator=" method sets the creator string which appears beneath 
    # an extension inside the Extensions Manager dialog.
		sl_random_materials.creator = "Sean Lin"

		
		# The "register_extension" method is used to register an extension with 
    # SketchUp's extension manager (in SketchUp preferences). This method must
    # be called after all the SketchupExtension methods have been called 
    # (those shown above).
		Sketchup.register_extension( sl_random_materials, true )

		
	end #module Random_Materials

end #module SLin
