require 'sketchup.rb'
require 'aatools/generic.rb'

module AATools
  module Nudger
    def self.do_vtx()
      am = Sketchup.active_model
      ae = am.active_entities
      p_container = Sketchup.active_model.active_path.to_a.last
      pct = p_container.local_transformation

      prompts = ['X', 'Y', 'Z']
      defaults = ['0', '0', '0']
      inputs = UI.inputbox(prompts, defaults, 'Nudge').map{|k| k.to_l }
      tx = Geom::Transformation.translation([inputs[0], inputs[1], inputs[2]])
      ae.transform_entities(pct * tx * pct.inverse, Generic.selection_vertices())
    end

    def self.nudge()
      do_vtx
    end

    def self.init(toolbar)
      menu = UI.menu('Plugins')
      menu.add_item('AATools Nudger') {
        self.nudge()
      }
      toolbar.add_item(
        Generic.create_command('Nudge', 'nudge24.png', 'Nudge vertices on faces or edges') { self.nudge })
    end
  end
end
