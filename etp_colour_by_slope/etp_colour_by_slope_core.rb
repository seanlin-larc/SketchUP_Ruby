=begin
Copyright 2017 Y-H Sean Lin
All Rights Reserved
Disclaimer
THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED 
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'sketchup.rb'
require 'etp_colour_by_slope.rb'

module ETP

	module Colour_by_Slope

		# This section loads the extension into the menu system. The 
    	# file_loaded? method is from the sketchup.rb file. It checks to see if
    	# a file has already been loaded.  This is to help prevent double loading
    	# of a script into the menu system, especially during development.
		if !file_loaded?(__FILE__)

			### MENU ###
			cmd_name = UI::Command.new("etp_colour_by_slope") {cmd}
			cmd_name.menu_text = "ETP Colour by Slope"
			cmd_name.set_validation_proc {
				if Sketchup.active_model.selection.length == 0
					MF_GRAYED
				else
					MF_ENABLED
				end
				}
			UI.menu("Extensions").add_item cmd_name
			
			### COMMAND ###
			def self.cmd
				model = Sketchup.active_model
				mats = model.materials
				sel = model.selection
						
				#Create an Undo point
				model.start_operation('ETP Colour by Slope', true)	
				
				#Warning message
				msg = "All materials on faces will be replaced. \nOK to continue. Cancel to abort."
				cnfm = UI.messagebox(msg, type = MB_OKCANCEL)
				return unless cnfm == 1

				#Create materials for being applied
				mat_flat = mats.add("Topo Flat")
				clr_flat = Sketchup::Color.new(113, 154, 63)
				mat_flat.color = clr_flat
				
				mat_gent = mats.add("Topo Gentle")
				clr_gent = Sketchup::Color.new(194, 219, 120)
				mat_gent.color = clr_gent
				
				mat_slpe = mats.add("Topo Slope")
				clr_slpe = Sketchup::Color.new(246, 235, 19)
				mat_slpe.color = clr_slpe

				mat_dfct = mats.add("Topo Difficult")
				clr_dfct = Sketchup::Color.new(245, 137, 32)
				mat_dfct.color = clr_dfct

				mat_exte = mats.add("Topo Extreme")
				clr_exte = Sketchup::Color.new(126, 36, 24)
				mat_exte.color = clr_exte

				#Set up criteria
				pct_40 = Math.cos(Math.atan(0.4))
				pct_30 = Math.cos(Math.atan(0.3))
				pct_20 = Math.cos(Math.atan(0.2))
				pct_10 = Math.cos(Math.atan(0.1))

				#Leave only faces in the selection
				sel_faces = []
				sel.each do |i|
					face_chk = i.class == Sketchup::Face
					if face_chk == true
						sel_faces << i
					end
				end #do sel.each
			
				sel_faces.each do |i|
					face_nml = i.normal
					face_nml_z = face_nml.z
					if face_nml_z < pct_40
						i.material = mat_exte						
					elsif face_nml_z < pct_30
							i.material = mat_dfct							
						elsif face_nml_z < pct_20
								i.material = mat_slpe
							elsif face_nml_z < pct_10
									i.material = mat_gent
								else
									i.material = mat_flat
					end #if
				end #do sel_faces.each
						
				#Mark the end of Undo point
				model.commit_operation	

				#Set current tool to "Selection Tool"
				Sketchup.send_action "selectSelectionTool:"
	
			end #def self.cmd	
 			
 			# This tells SU that the file is loaded into the menu system
 			file_loaded(__FILE__)
 		end #if !file_loaded

	end #module Colour_by_Slope

end #module ETP 