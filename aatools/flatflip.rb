require 'sketchup.rb'
require 'aatools/generic.rb'

module AATools
  module Flatflip
    def self.flat_flip(xsc, ysc, zsc)
      am = Sketchup.active_model
      ae = am.active_entities
      as = am.selection
      fvp = as.first.vertices.first.position
      ae.transform_entities(Geom::Transformation.scaling(fvp, xsc, ysc, zsc), as)
    end

    def self.init(toolbar)
      menu = UI.menu('Plugins')
      submenu = menu.add_submenu('AATools Flatflip')
      submenu.add_item('Flip X') {
        self.flat_flip_x
      }
      submenu.add_item('Flip Y') {
        self.flat_flip_y
      }
      submenu.add_item('Flip Z') {
        self.flat_flip_z
      }
      commands = [
        Generic
          .create_command('Flatflip X', 
            'flatflipx24.png', 
            'Flip vertices across first vertex X axis') { self.flat_flip(-1.00, 1.00, 1.00) },
        Generic
          .create_command('Flatflip Y', 
            'flatflipy24.png', 
            'Flip vertices across first vertex Y axis') { self.flat_flip(1.00, -1.00, 1.00) },
        Generic
          .create_command('Flatflip Z', 
            'flatflipZ24.png', 
            'Flip vertices across first vertex Z axis') { self.flat_flip(1.00, 1.00, -1.00) },
      ]
      commands.reduce(toolbar) { |tb,c| tb.add_item c }
    end
  end
end
