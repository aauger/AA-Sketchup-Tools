module AATools
  module Generic
    @@images_path = nil

    def self.selection_entities()
      Sketchup.active_model.selection.to_a
    end

    def self.selection_vertices()
      selection_entities.select{|e| (e.is_a? Sketchup::Face) or (e.is_a? Sketchup::Edge)}.flat_map{|e| e.vertices}
    end

    def self.create_command(name, icon_filename, tooltip="")
      cmd = UI::Command.new(name) {
        yield
      }
      cmd.small_icon = File.join(Generic.path_images, icon_filename)
      cmd.large_icon = File.join(Generic.path_images, icon_filename)
      cmd.tooltip = tooltip
      cmd 
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
end
