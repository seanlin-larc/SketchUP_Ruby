=begin
Copyright 2017 Y-H Sean Lin
All Rights Reserved
Script Name:
etp_colour_by_slope.rbz
Description:
This a Sketchup Ruby script to assign different colour to selected faces
based on the slope (normals) of faces.
Usage:
Access the extension from the menu "Entensions > ETP Colour by Slope".
History:
1.0.0 - 2017-1-19
	* First release
Disclaimer:
THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED 
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
=end


# The whole thing is wrapped in a SU_Extensions module
# Developers should wrap their extensions inside their own modules.
module ETP # <--Change this to your own personal name space

	# This entire script is wrapped inside its own module,
  # inside of our SU_Extensions module.
	module Colour_by_Slope # <--Change this to your own scripts name space

		# Common required files for creating extensions
		require 'sketchup.rb'
		require 'extensions.rb'
		require 'langhandler.rb'


		# The "new" method is used to create a new SketchupExtension object. 
		# Note that once the extension object is created, it will not appear in 
   		# the Extension Manager dialog until your register it with the 
  		# Sketchup.register_extension method.
		etp_colour_by_slope = SketchupExtension.new("ETP Colour by Slope", "etp_colour_by_slope/etp_colour_by_slope_core.rb")


		# The "name=" method sets the name which appears for an 
    	# extension inside the Extensions Manager dialog.
		etp_colour_by_slope.name = "ETP Colour by Slope"


		# The "description=" method sets the long description which appears 
    	# beneath an extension inside the Extensions Manager dialog.
		etp_colour_by_slope.description = "This extension assigns different " + "colour to selected faces based on the slope of faces"


		# The "version" method sets the version which appears beneath an extension
	    # inside the Extensions Manager dialog.  This is recommended to be a 
   		# major.minor.revision versioning scheme.
		etp_colour_by_slope.version = '1.0.0'


		# The "copyright=" method sets the copyright string which appears 
    	# beneath an extension inside the Extensions Manager dialog.
		etp_colour_by_slope.copyright = "2017"
		 
		 
		# The "creator=" method sets the creator string which appears beneath 
    	# an extension inside the Extensions Manager dialog.
		etp_colour_by_slope.creator = "Y-H Sean Lin"

		
		# The "register_extension" method is used to register an extension with 
    	# SketchUp's extension manager (in SketchUp preferences). This method must
    	# be called after all the SketchupExtension methods have been called 
    	# (those shown above).
		Sketchup.register_extension( etp_colour_by_slope, true )

		
	end #module Colour_by_Slope

end #module ETP