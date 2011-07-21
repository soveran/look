module Look
  # Current version of Look.
  VERSION = "0.1.0"

  # Standard location for "plugins" within the load path.
  PLUGIN_DIRECTORY = "plugins"

  # Add a +directory+ to the $LOAD_PATH.
  #
  #   Look.at('lib')
  #
  # NOTE: This does not ensure the directories actually exist.
  # It simply adds them to the $LOAD_PATH regardless.
  #++
  def self.at(*directory)
    raise ArgumentError if directory.empty?
    dir = File.expand_path(File.join(*directory))
    Dir[dir].each { |lib| $:.unshift(lib) }
  end

  # Same as +Look.at+ but assume's the locations are vendered projects
  # within the standard +vendor/+ directory. So, for example:
  #
  #   Look.at_vendor File.dirname(__FILE__)
  #
  # is equivalent to:
  #
  #   Look.at File.dirname(__FILE__) + '/vendor/*/lib'
  #
  def self.at_vendor(dir, glob=:vendor)
    raise ArgumentError unless dir
    at(dir, "vendor/*/lib")
  end

  # Find plugins, searching through standard $LOAD_PATH, as well as RubyGems
  # and Roller paths if they are being used.
  #
  #   Look.up('rdoc/discover.rb')
  #
  def self.up(match, options={})
    list = []
    list.concat up_rollers(match, options)
    list.concat up_loadpath(match, options)
    list.concat up_rubygems(match, options)
    list.uniq
  end

  # This is the same as +up+ but searches within the standard +plugins/+
  # directory. Using the standard +plugins+ directory makes it easier for
  # developers to locate plugins, and helps prevent file name clashes with
  # regular library scripts. For example, if your project is called 'milkdud'
  # and it supports plugin scripts, they would reside in the a project's 
  # <code>lib/plugins/milkdud/</code> directory.
  #
  #   Look.up('syckle/*')
  #
  def self.up_plugins(match, options={})
    options[:directory] ||= PLUGIN_DIRECTORY
    up(match, options)
  end

  # Search standard $LOAD_PATH.
  # Activated gem versions are in here too.
  def self.up_loadpath(match, options={})
    matches = []
    directory = options[:directory] || '' #PLUGIN_DIRECTORY
    $LOAD_PATH.uniq.each do |path|
      path = File.expand_path(path)
      list = Dir.glob(File.join(path, directory, match))
      #dirs = dirs.select{ |d| File.directory?(d) }
      list = list.map{ |d| d.chomp('/') }
      matches.concat(list)
    end
    matches
  end

  # Search RubyGems for matching paths in latest gem versions.
  #--
  # TODO: Is there anyway to skip active gems?
  #++
  def self.up_rubygems(match, options={})
    matches = []
    directory = options[:directory] || '' #PLUGIN_DIRECTORY
    if defined?(::Gem)
      ::Gem.latest_load_paths do |path|
        list = Dir.glob(File.join(path, directory, match))
        list = list.map{ |d| d.chomp('/') }
        matches.concat(list)
      end
    end
    matches
  end

  # Search Roller for current or latest libraries.
  def self.up_rollers(match, options={})
    matches = []
    directory = options[:directory] || '' #PLUGIN_DIRECTORY
    if defined?(::Roll) #Library
      ::Library.ledger.each do |name, lib|
        lib = lib.sort.first if Array===lib
        lib.loadpath.each do |path|
          find = File.join(lib.location, path, directory, match)
          list = Dir.glob(find)
          list = list.map{ |d| d.chomp('/') }
          matches.concat(list)
        end
      end
    end
    matches
  end

end
