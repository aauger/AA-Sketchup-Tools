require 'sketchup.rb'

module AATools

  module Generic
    @@images_path = nil

    def self.selection_edges()
      Sketchup.active_model.selection.to_a
    end

    def self.selection_vertices()
      selection_edges.flat_map{|e| e.vertices}
    end

    def self.path_images
      if @@images_path.nil?
        file = __FILE__.dup
        # Account for Ruby encoding bug under Windows.
        file.force_encoding('UTF-8') if file.respond_to?(:force_encoding)
        # Support folder should be named the same as the root .rb file.
        folder_name = File.basename(file, '.*')

        path_root = File.dirname(file)
        @@images_path = File.join(path_root, 'images')
      else
        @@images_path
      end
    end
  end


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
      cmd = UI::Command.new('Nudge') {
        self.nudge()
      }
      cmd.small_icon = File.join(Generic.path_images, 'nudge24.png')
      cmd.large_icon = File.join(Generic.path_images, 'nudge24.png')
      cmd.tooltip = "Nudge vertices on faces or edges"
      toolbar.add_item cmd
    end
  end

  module Multipusher
    def self.multi_push()
      am = Sketchup.active_model
      as = am.selection
      faces = as.to_a.select{|e| e.is_a? Sketchup::Face}

      prompts = ['Push Distance']
      defaults = [0.to_l.to_s]
      push_d = UI.inputbox(prompts, defaults, 'Multipush').first.to_l
      am.start_operation('Multipush', true, false, false)
      faces.each do |e|
        e.pushpull(push_d)
      end
      am.commit_operation
    end

    def self.init(toolbar)
      menu = UI.menu('Plugins')
      menu.add_item('AATools Multipush') {
        self.multi_push
      }
      cmd = UI::Command.new('Multipush') {
        self.multi_push()
      }
      cmd.small_icon = File.join(Generic.path_images, 'multipush24.png')
      cmd.large_icon = File.join(Generic.path_images, 'multipush24.png')
      cmd.tooltip = "Push multiple faces"
      toolbar.add_item cmd
    end
  end

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

  module Desoften
  end
end
