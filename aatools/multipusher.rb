require 'sketchup.rb'
require 'aatools/generic.rb'

module AATools
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
      toolbar.add_item(
        Generic.create_command('Multipush', 'multipush24.png', 'Push multiple faces') { self.multi_push })
    end
  end
end
