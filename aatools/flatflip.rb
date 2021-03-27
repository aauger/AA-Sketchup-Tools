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

    def self.flat_flip_x()
      flat_flip(-1.00, 1.00, 1.00)
    end

    def self.flat_flip_y()
      flat_flip(1.00, -1.00, 1.00)
    end

    def self.flat_flip_z()
      flat_flip(1.00, 1.00, -1.00)
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
      l_toolbar = toolbar
      cmd = UI::Command.new('Flatflip X') {
        self.flat_flip_x()
      }
      cmd.small_icon = File.join(Generic.path_images, 'flatflipx24.png')
      cmd.large_icon = File.join(Generic.path_images, 'flatflipx24.png')
      l_toolbar = l_toolbar.add_item cmd

      cmd = UI::Command.new('Flatflip Y') {
        self.flat_flip_y()
      }
      cmd.small_icon = File.join(Generic.path_images, 'flatflipy24.png')
      cmd.large_icon = File.join(Generic.path_images, 'flatflipy24.png')

      l_toolbar = l_toolbar.add_item cmd

      cmd = UI::Command.new('Flatflip Z') {
        self.flat_flip_z()
      }
      cmd.small_icon = File.join(Generic.path_images, 'flatflipz24.png')
      cmd.large_icon = File.join(Generic.path_images, 'flatflipz24.png')
      l_toolbar = l_toolbar.add_item cmd
      l_toolbar
    end
  end
end
