#test

require 'sketchup.rb'
require 'extensions.rb'
require 'aatools/generic.rb'

module AATools

  unless file_loaded?(__FILE__)
    ex = SketchupExtension.new('AATools', 'aatools/main')
    ex.description = 'Sketchup tools'
    ex.version     = '1.0.0'
    ex.copyright   = 'AA 2020'
    ex.creator     = 'AA'
    Sketchup.register_extension(ex, true)
    file_loaded(__FILE__)
    toolbar = UI::Toolbar.new("AATools")
    modules = 
        [Nudger, 
         Multipusher, 
         Flatflip,
         Dims, 
         Snappy]
    toolbar = modules.reduce(toolbar) {|tb,m| m.init(tb)}
    toolbar.show
    @@extension = ex
  end

  def self.extension
    @@extension
  end
end