require 'fileutils'

namespace :gemini do
  namespace :views do

    task :update => :environment do
      Gemini::ViewUpdater.new.generate_rails_views
      puts "Views updated."
    end

  end
end

module Gemini
  class ViewUpdater

    def gemini_root_dir
      @gemini_root_dir ||= File.expand_path('..', Dir.getwd())
    end

    def generate_rails_views
      resource_folders.map { |f| File.basename(f) }.each do |subfolder|
        rails_view_subfolder = File.join(gemini_root_dir, ".website/app/views", subfolder)
        gemini_views = Dir["#{File.join(gemini_root_dir, subfolder)}/*.html.erb"]

        FileUtils.mkdir_p rails_view_subfolder
        FileUtils.symlink gemini_views, rails_view_subfolder, force: true

        controller_filename = File.join(gemini_root_dir, '.website/app/controllers', "#{subfolder}_controller.rb")
        if !File.exist?(controller_filename)
          File.open(controller_filename, "w") do |f|
            controller_class_name = (subfolder.underscore + "_controller").classify
            f.puts "class #{controller_class_name} < ApplicationController"
            f.puts "end"
          end
        end
      end
    end

    def excluded_folders
      ["#{gemini_root_dir}/website/"]
    end

    def resource_folders
      Dir["#{gemini_root_dir}/*/"] - excluded_folders
    end

  end
end
