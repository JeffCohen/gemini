class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  %w(index show new create edit update destroy).each do |action_name|
    define_method action_name do
      gemini_resource = self.class.name.sub('Controller', '').underscore
      filename = "../#{gemini_resource}/#{action_name}.rb"
      if File.exist?(filename)
        code = IO.read("../#{gemini_resource}/index.rb")
        binding.eval(code)
      end
    end
  end

end
