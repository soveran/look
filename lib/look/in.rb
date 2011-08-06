module Look

  # Add a +directory+ to the $LOAD_PATH.
  #
  #   Look.in('lib')
  #
  # Note that this does not ensure the directory actually exists.
  # It simply adds the path to the $LOAD_PATH regardless.
  #
  def self.in(*directory)
    raise ArgumentError if directory.empty?
    dir = File.expand_path(File.join(*directory))
    Dir[dir].each { |lib| $:.unshift(lib) }
    return $:
  end

end
