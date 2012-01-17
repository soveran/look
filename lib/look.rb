module Look
  VERSION = "0.0.1"

  def self.at(dir, glob = "vendor/*/lib")
    unless File.directory?(dir)
      raise ArgumentError, "#{dir} is not a directory"
    end

    $:.unshift(*Dir[File.join(dir, glob)])
  end
end
