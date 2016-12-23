=begin
Copyright 2017 Sean Lin
seanlin.larc[at]gmail.com
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

module SL
	module Extensions
		module SL_Random_Materials

			### CONSTANTS ###
			# Extension Information
			EXTENSION		= self
			EXTENSION_ID	= 'SL_Random_Materials'.freeze
			EXTENSION_NAME	= 'SL Randomly Apply Materials'.freeze
		
			# Resource paths
			file = File.expand_path ( _FILE_ )
			file.force_encoding ("UTF-8) if file.respond_to? ( :force_encoding )
			FILENAMESPCAE	= File.basename( file, '.*')
			PATH_ROOT		= File.dirname( file ).freeze
			PATH			= File.join( PATH_ROOT, FILENAMESPACE ).freeze

			# Common required files for creating extensions
			require 'sketchup.rb'
			require 'extensions.rb'
			require 'langhandler.rb'

			### MENU ###
			# The "new" method is used to create a new SketchupExtension object. 
			# Note that once the extension object is created, it will not appear in 
    		# the Extension Manager dialog until your register it with the 
    		# Sketchup.register_extension method.
		
			unless file_loaded?( _FILE_ )
				file = File.join( PATH, 'sl_random_materials_core.rb')
				extn = SketchExtension.new( EXTENSION_NAME, file)
				extn.description = "Randomly apply materials to faces by assigned propotion"
				extn.version = '1.0.0'
					extn.copyright = 'Sean Lin @2017'
				extn.creator = 'Sean Lin (seanlinlarc@gmail.com)'
				Sketchup.register_extension(extn, true)
			end
		
		end # module SL_Random_Materials
	end # module Extensions
end # module SL
