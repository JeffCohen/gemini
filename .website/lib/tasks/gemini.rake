require 'fileutils'

namespace :gemini do
  namespace :symlinks do

    task :update => :environment do
      Gemini::SymlinksUpdater.new.generate_links
      puts "Symlinks updated."
    end

  end
end

module Gemini
  class SymlinksUpdater

    def gemini_root_dir
      @gemini_root_dir ||= File.expand_path('..', Dir.getwd())
    end

    def generate_links
      rails_layout = "/.website/app/views/layouts/application.html.erb"
      gemini_layout = 'layout.html.erb'
      FileUtils.symlink rails_layout, gemini_layout, force: true

      rails_models_yml = "/.website/db/models.yml"
      gemini_models_yml = 'models.yml'
      FileUtils.symlink rails_models_yml, gemini_models_yml, force: true
    end
  end
end
