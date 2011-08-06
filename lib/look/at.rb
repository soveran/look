module Look

  # Same as +Look.at+ but assume's the locations are vendered projects
  # within the standard +vendor/+ directory. So, for example:
  #
  #   Look.at_vendor File.dirname(__FILE__)
  #
  # is equivalent to:
  #
  #   Look.at File.dirname(__FILE__) + '/vendor/*/lib'
  #
  def self.at(*directory)
    raise ArgumentError if directory.empty?

    opt = Hash === directory.last ? directory.pop : {}
    dir = File.expand_path(File.join(*directory))

    return $:.unshift(dir) if opt[:direct]

    gemspecs = Dir.glob(File.join(dir, '*/{*,}.gemspec'))
    dotrubys = Dir.glob(File.join(dir, '*/.ruby'))
    libpaths = Dir.glob(File.join(dir, '*/lib'))

    # TODO: if no paths fallback to direct path --good idea?
    return $:.unshift(dir) if gemspecs.empty? && dotrubys.empty? && libpaths.empty?

    # TODO: more efficient means of prevent duplicate paths?
    index = []

    dotrubys.each do |path|
      root = File.dirname(path)
      next if index.include?(root)
      index << root

      spec = YAML.load(path)
      spec['load_path'].each do |lp|
        $:.unshift(File.join(root, rp))
      end
    end

    if defined?(::Gem) # only if rubygems is in use
      gemspecs.each do |path|
        root = File.dirname(path)
        next if index.include?(root)
        index << root

        # TODO: handle YAML gemspecs
        spec = Gem::Specification.load(path)
        spec.require_paths.each do |rp|
          $:.unshift(File.join(root, rp))
        end
      end
    end

    libpaths.each do |path|
      root = File.dirname(path)
      next if index.include?(root)
      index << root

      $:.unshift(path)
    end

    return $:
  end

end
