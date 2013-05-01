MRuby::Build.new do |conf|
  # load specific toolchain settings
  toolchain :vs2012

  # Use mrbgems
  # conf.gem 'examples/mrbgems/ruby_extension_example'
  # conf.gem 'examples/mrbgems/c_extension_example' do |g|
  #   g.cc.flags << '-g' # append cflags in this gem
  # end
  # conf.gem 'examples/mrbgems/c_and_ruby_extension_example'
  # conf.gem :github => 'masuidrive/mrbgems-example', :branch => 'master'
  # conf.gem :git => 'git@github.com:masuidrive/mrbgems-example.git', :branch => 'master', :options => '-v'

  # include the default GEMs
  conf.gembox 'default'

  # C compiler settings
  # conf.cc do |cc|
  #   cc.command = ENV['CC'] || 'gcc'
  #   cc.flags = [ENV['CFLAGS'] || %w()]
  #   cc.include_paths = ["#{root}/include"]
  #   cc.defines = %w(DISABLE_GEMS)
  #   cc.option_include_path = '-I%s'
  #   cc.option_define = '-D%s'
  #   cc.compile_options = "%{flags} -MMD -o %{outfile} -c %{infile}"
  # end

  # Linker settings
  # conf.linker do |linker|
  #   linker.command = ENV['LD'] || 'gcc'
  #   linker.flags = [ENV['LDFLAGS'] || []]
  #   linker.flags_before_libraries = []
  #   linker.libraries = %w()
  #   linker.flags_after_libraries = []
  #   linker.library_paths = []
  #   linker.option_library = '-l%s'
  #   linker.option_library_path = '-L%s'
  #   linker.link_options = "%{flags} -o %{outfile} %{objs} %{libs}"
  # end
 
  # Archiver settings
  # conf.archiver do |archiver|
  #   archiver.command = ENV['AR'] || 'ar'
  #   archiver.archive_options = 'rs %{outfile} %{objs}'
  # end
 
  # Parser generator settings
  # conf.yacc do |yacc|
  #   yacc.command = ENV['YACC'] || 'bison'
  #   yacc.compile_options = '-o %{outfile} %{infile}'
  # end
 
  # gperf settings
  # conf.gperf do |gperf|
  #   gperf.command = 'gperf'
  #   gperf.compile_options = '-L ANSI-C -C -p -j1 -i 1 -g -o -t -N mrb_reserved_word -k"1,3,$" %{infile} > %{outfile}'
  # end
  
  # file extensions
  # conf.exts do |exts|
  #   exts.object = '.o'
  #   exts.executable = '' # '.exe' if Windows
  #   exts.library = '.a'
  # end

  # file separetor
  # conf.file_separator = '/'
end

# Define cross build settings
# MRuby::CrossBuild.new('32bit') do |conf|
#   toolchain :gcc
#   
#   conf.cc.flags << "-m32"
#   conf.linker.flags << "-m32"
#
#   conf.build_mrbtest_lib_only
#   
#   conf.gem 'examples/mrbgems/c_and_ruby_extension_example'
#
#   conf.test_runner.command = 'env'
#
# end

MRuby::CrossBuild.new('winrt-arm-dbg') do |conf|
  toolchain :vs2012

  cl = 'cl.exe'
  ENV['PATH'].split(File::PATH_SEPARATOR).each do |pdir|
    if File.exist?("#{pdir}#{File::ALT_SEPARATOR}cl.exe")
      cl = "#{pdir}#{File::ALT_SEPARATOR}x86_arm#{File::ALT_SEPARATOR}cl.exe"
      break
    end
  end
  conf.cc.command = cl
  conf.cc.flags << " /D_ARM_WINAPI_PARTITION_DESKTOP_SDK_AVAILABLE /DDISABLE_STDIO /TP /ZW:nostdlib"
  conf.linker.flags << " /MACHINE:ARM"
  conf.build_mrbtest_lib_only
  
  conf.bins = %w()
  conf.gem 'examples/mrbgems/c_and_ruby_extension_example'

end

MRuby::CrossBuild.new('nostdio-dbg') do |conf|
  toolchain :vs2012

  conf.cc.flags << " /DDISABLE_STDIO /TP  /ZW:nostdlib"
  conf.build_mrbtest_lib_only
  
  conf.bins = %w()
  conf.gem 'examples/mrbgems/c_and_ruby_extension_example'
end

MRuby::CrossBuild.new('winrt-arm') do |conf|
  toolchain :vs2012

  cl = 'cl.exe'
  ENV['PATH'].split(File::PATH_SEPARATOR).each do |pdir|
    if File.exist?("#{pdir}#{File::ALT_SEPARATOR}cl.exe")
      cl = "#{pdir}#{File::ALT_SEPARATOR}x86_arm#{File::ALT_SEPARATOR}cl.exe"
      break
    end
  end
  conf.cc.command = cl
  conf.cc.flags = %w(/c /nologo /W3 /MD /Zi /Od /DHAVE_STRING_H /DNO_GETTIMEOFDAY /D_CRT_SECURE_NO_WARNINGS /D_ARM_WINAPI_PARTITION_DESKTOP_SDK_AVAILABLE /DDISABLE_STDIO /TP /ZW:nostdlib /DNDEBUG)
  conf.linker.flags << " /MACHINE:ARM"
  conf.build_mrbtest_lib_only
  
  conf.bins = %w()
  conf.gem 'examples/mrbgems/c_and_ruby_extension_example'  

end

MRuby::CrossBuild.new('nostdio') do |conf|
  toolchain :vs2012

  conf.cc.flags = %w(/c /nologo /W3 /Zi /Od /DHAVE_STRING_H /DNO_GETTIMEOFDAY /D_CRT_SECURE_NO_WARNINGS /DDISABLE_STDIO /TP /MD /ZW:nostdlib /DNDEBUG)  
  conf.build_mrbtest_lib_only
  
  conf.bins = %w()
  conf.gem 'examples/mrbgems/c_and_ruby_extension_example'  
end

