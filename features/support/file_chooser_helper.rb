module Swinger
  module FileChooser
    java_import org.netbeans.jemmy.operators.JFileChooserOperator

    def file_chooser(container = container.current)
      container_check! container, "FileChooser"
      JFileChooserOperator.new(container)
    end
  end
end
World(Swinger::FileChooser)