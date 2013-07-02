class Savanna::Assets::FileNotFound < Exception
  def initialize
    super "Please make 'savanna' file to precompile, check this: https://github.com/shawnjung/savanna"
  end
end

class Savanna::Assets::EmptyPrecompileList < Exception
  def initialize
    super "No precompile files in the 'savanna' file."
  end
end