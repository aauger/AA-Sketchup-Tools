require 'sketchup.rb'
require 'aatools/generic.rb'

module AATools
	module Snappy
		def self.snappy_switch
			model_options = Sketchup.active_model.options[0]
			n_value = !model_options["LengthSnapEnabled"]
			model_options["LengthSnapEnabled"] = n_value
			model_options["AngleSnapEnabled"] = n_value
			(UI::Notification.new(AATools.extension, 'Snapping: %s' % [n_value.to_s])).show
		end

		def self.init(toolbar)
      menu = UI.menu('Plugins')
      menu.add_item('AATools Snappy') {
        self.snappy_switch
      }
      toolbar.add_item(
        Generic.create_command('Snappy', 'snappy24.png', 'Disable/enable model snapping to follow image patterns easily') { self.snappy_switch })
		end
	end
end