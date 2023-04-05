#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "3.0"

define_target "nghttp3" do |target|
	target.depends :platform
	
	target.depends "Library/picotls", public: true
	
	target.depends "Build/Make"
	target.depends "Build/CMake"
	
	target.provides "Library/nghttp3" do
		source_files = target.package.path + "nghttp3"
		cache_prefix = environment[:build_prefix] / environment.checksum + "nghttp3"
		package_files = [
			cache_prefix / "lib/nghttp3_static.a",
		]
		
		cmake source: source_files, install_prefix: cache_prefix, arguments: [
			# "-DENABLE_SHARED_LIB=OFF",
		], package_files: package_files
		
		append linkflags package_files
		append header_search_paths cache_prefix + "include"
	end
end

define_configuration "development" do |configuration|
	configuration[:source] = "https://github.com/kurocha/"
	
	configuration.import "nghttp3"
	
	configuration.require "platforms"
	
	configuration.require "build-make"
	configuration.require "build-cmake"
	
end

define_configuration "nghttp3" do |configuration|
	configuration.public!
	
	configuration.require "ngtcp2"
end
