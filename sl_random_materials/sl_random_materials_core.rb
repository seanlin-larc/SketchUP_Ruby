=begin
Copyright 2017 Y-H Sean Lin
All Rights Reserved
Disclaimer
THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED 
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'sketchup.rb'
require 'sl_random_materials.rb'

module SLin

	module Random_Materials

		# This section loads the extension into the menu system. The 
    	# file_loaded? method is from the sketchup.rb file. It checks to see if
    	# a file has already been loaded.  This is to help prevent double loading
    	# of a script into the menu system, especially during development.
		if !file_loaded?(__FILE__)

			### MENU ###
			cmd_name = UI::Command.new("sl_random_materials") {cmd}
			cmd_name.menu_text = "SL Randomly Apply Materials"
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
				sel = model.selection
				ents = model.active_entities
		
				#Create an Undo point
				model.start_operation('SL Random Materials', true)	
				
				#Leave only faces in the selection
				sel_faces = []
				sel.each do |i|
					face_chk = i.class == Sketchup::Face
					if face_chk == true
						sel_faces << i
					end
				end #do sel.each
			
				#Extract materials from selected faces
				sel_mats = []
				sel_faces.each do |i|
					mat = i.material
					sel_mats << mat
				end #do sel_faces.each
				sel_mats.uniq! #Keep only unique materials
				sel_mats.compact! #Remove "Default" material.
				
						
				#Check number of materials
				#End Script if only one material is selected
				if sel_mats.length < 2
					UI.messagebox("Need more than TWO materials to run the script", type = MB_OK)
					return
					else
						#Confirm number of materials
						confirm = UI.messagebox("#{sel_mats.length} materials are selected. \nOK to continue; Cancel to Abort.", type = MB_OKCANCEL) 	
						return unless confirm == 1						 
				end #if sel_mats.length
						
				#Assign seeds to materials
				ary_mats_seeds = []
				tot_seeds = 0.0
				mats_pct_desc = ""
				
				sel_mats.each do |i|
					mat_id = i
					mat_name = i.name
					UI.messagebox("Proportion of a material is the seed of material 
						\ndivided by the total seeds.
						\nTotal seeds is #{tot_seeds} now.",
						type=MB_OK)
					prompt = ["Number of Seeds for material \"#{mat_name}\":"]
					default = [0]
					mat_seed = UI.inputbox(prompt, default, "Input Number of Seeds for material #{mat_name}").at(0).to_f
					return if !mat_seed
					tot_seeds += mat_seed
					hash_mat_seed = {:mat_id => mat_id, :mat_name => mat_name, :mat_seed => mat_seed, :mat_accum_seed => tot_seeds, :mat_count => 0}
					ary_mats_seeds << hash_mat_seed
				end #do sel_mats.each
								
				#Calculate proportion
				mat_seed_pct = 0.0
				accum_seed_pct = 0.0
				ary_mats_seeds.each do |i|
					mat_seed_pct = ((i[:mat_seed] / tot_seeds).round(4) * 100)
					accum_seed_pct += mat_seed_pct
					i[:mat_pct] = mat_seed_pct
					i[:mat_accum_pct] = accum_seed_pct
					#Make a description
					mats_pct_desc += "#{i[:mat_name]} will take approximate #{i[:mat_pct]}%.\n"
				end #do ary_mats_seeds.each
			
				#Display materials and their proportions
				confirm = UI.messagebox("#{mats_pct_desc} \n OK to continue. \n Cancel to abort.", type = MB_OKCANCEL)
				return unless confirm == 1 
						
				#Assigning materials to faces
				sel_faces.each do |i|
					rand_pct = rand(100)
					ary_mats_seeds.each do |m| 
						chk = rand_pct <= m[:mat_accum_pct]
						if chk == true
							i.material = m[:mat_id]
							m[:mat_count] += 1
							break
						end
					end #do ary_mats_seeds.each
				end #do sel_faces.each

				#Generate report
				faces_count_msg = sel_faces.length
				mats_count_msg = ""
				ary_mats_seeds.each do |i|
					mats_count_msg += "#{i[:mat_name]} is applied to #{i[:mat_count]} faces. \n"

				end #do ary_mats_seeds.each
				UI.messagebox("#{faces_count_msg} faces are painted. \n#{mats_count_msg}", type = MB_OK)

				#Mark the end of Undo point
				model.commit_operation	

				#Set current tool to "Selection Tool"
				Sketchup.send_action "selectSelectionTool:"
	
			end #def self.cmd	
 			
 			# This tells SU that the file is loaded into the menu system
 			file_loaded(__FILE__)
 		end #if !file_loaded

	end #module Random_Materials

end #module SLin 
