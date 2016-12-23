=begin
Copyright 2017 Sean Lin
All Rights Reserved

Disclaimer
THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED 
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
=end


module SL_Random_Materials # <--Change this to your own personal name space

	module Random_Materials # <--Change this to your own scripts name space

		def command
			model = Sketchup.active_model
			sel = model.selection
			ents = model.active_entities
			sel.add( ents.to_a )
		end # main
		
		def self.msgbox(msg)
			UI.messagebox( msg )
		end
		
	end #module	
  
end #module

