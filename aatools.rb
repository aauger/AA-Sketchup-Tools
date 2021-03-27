#test

require 'sketchup.rb'
require 'extensions.rb'

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
    toolbar = AATools::Nudger.init(toolbar)
    toolbar = AATools::Multipusher.init(toolbar)
    toolbar = AATools::Flatflip.init(toolbar)
    toolbar.show
  end
end
