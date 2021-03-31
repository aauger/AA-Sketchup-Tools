require 'sketchup.rb'
require 'aatools/generic.rb'

module AATools
	module Dims
		def self.show_dims
			selection = Generic.selection_entities.first
			st_result = "The selection was not a valid edge"
			if selection.is_a?(Sketchup::Edge)
				length = selection.length
				st_result = "Feet & Inches: %s\nInches: %s\"\nCentimeters: %scm" % [length.to_s, length.to_inch.to_s, length.to_cm.to_s]
			end
			UI.messagebox(st_result, MB_MULTILINE)
		end

		def self.init(toolbar)
      menu = UI.menu('Plugins')
      menu.add_item('AATools Dims') {
        self.show_dims
      }
      toolbar.add_item(
        Generic.create_command('Dims', 'dims24.png', 'Show dimensions in multiple units') { self.show_dims })
		end
	end
end