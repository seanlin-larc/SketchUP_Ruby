=begin
Copyright 2017 Sean Lin
All Rights Reserved
Disclaimer
THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED 
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'sketchup.rb'
require 'sl_random_materials.rb'

module SL::Extensions::SL_Random_Materials

	### MENU ###
	cmd = UI:Command.new("sl_random_materials")
	cmd.menu_text = "SL Randomly Apply Materials"
	cmd.set_validation_proc {
		if Sketchup.active_model.selection.length == 0
			MF_GRAYED
		else
			MF_ENABLED
		end}
	UI.menu("Extensions").add_item cmd
	
	### COMMAND ###
	def cmd
		model = Sketchup.active_model
		sel = model.selection
		ents = model.active_entities
	
		#Create an Undo point
		model.start_opperation('SL Random Materials', true)	
		
		#Leave only faces in the selection
		sel_faces = []
		sel.each {|i|
			if sel[i].class == Sketchup::Face
				sel_faces << sel[i]
			end
			}
		
		#Extract materials from selected faces
		sel_mats = []
		sel_faces.each {|i|
			mat = sel_faces[i].material
			sel_mats << mat
			}
		sel_mats.uniq! #Keep only unique materials
		sel_mats.compact! #Remove "Default" material.
		
			
		#Check number of materials
		#End Script if only one material is selected
		if sel_mats.length <2
			UI.messagebox("Need more than TWO materials to run the script" type=MB_OK)
			break
		else
			#Confirm number of materials
			confirm = UI.messagebox("#{sel_mats.length} materials are selected. \nOK to continue; Cancel to Abort.", type = MB_OKCANCEL) 	
			break unless confirm == 1
		end #if sel_mats.length
				
		#Assign seeds to materials
		ary_mats_seeds = []
		tot_seeds = 0
		mats_pct_desc = ""
		
		sel_mats.each {|i|
			mat_id = sel_mats[i]
			mat_name = sel_mats[i].name
			UI.messagebox("Proportion of a material is the seed of material 
				\ndivided by the total seeds.
				\nTotal seeds is #{tot_seeds} now.",
				type=MB_OK)
			prompt = ["Number of Seeds for material \"#{mat_name}\":"]
			default = [0]
			mat_seed = UI.inputbox(prompt, default, "Input Number of Seeds for material #{mat_name}").at(0)
			tot_seeds += mat_seed
			hash_mat_seed = {:mat_id => mat_id, :mat_name => mat_name, :mat_seed => mat_seed, :mat_accum_seed => tot_seeds}
			ary_mats_seeds << hash_mat_seed
			} #End sel_mats.each
		
		#Calculate proportion
		ary_mats_seeds.each {|i|
			hash_mat_seed_pct = (ary_mats_seeds[i].to_f / tot_seeds.to_f).round(4) * 100)
			ary_mats_seeds[i][:mat_pct] = hash_mat_seed_pct
			#Make a description
			mats_pct_desc += "#{ary_mats_seeds[i][:mat_name]} will take #{ary_mats_seeds[i][:mat_pct]} %. \n"
			} #Enad ary_mats_seeds.each
		
		#Display materials and their proportions
		confirm = UI.messagebox("#{mats_pct_desc} \n OK to continue. \n Cancel to abort.", type = MB_OKCANCEL)
		break unless confirm == 1
		
		
#Assigning materials to faces
		
		sel_faces.each {|i|
			agnt = rand(tot_seeds)
			ary_mats_seeds.each {|m| 
				retrn = agnt <= ary_mats_seeds[m][:mat_accum_seed]
				if return = true
				sel_faces[i].material = ary_mats_seeds[m][:mat_id]
				end #if
			} #end ary_mats_seeds.each
		} #end sel_faces.each
		
		#Mark the end of Undo point
		model.commit_opperation	

		#Set current tool to "Selection Tool"
		Sketchup.send_action "selectSelectionTool:"
	
	end # cmd	
 
end #module
