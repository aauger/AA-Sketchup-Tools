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
end
