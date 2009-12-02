module Swinger
  module FileChooser
    java_import org.netbeans.jemmy.operators.JFileChooserOperator

    def file_chooser
      JFileChooserOperator.new
    end
  end
end
World(Swinger::FileChooser)