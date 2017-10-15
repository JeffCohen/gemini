Rails.application.routes.draw do

  (Dir["../*/"] - ['.website']).map { |f| File.basename(f) }.each do |folder|

    Dir["../#{folder}/*.html.erb"].map { |f| File.basename(f.downcase, '.html.erb') }.each do |file|
      if !%w(index show new edit create update destroy).include?(file)
        get "/#{folder}/#{file}" => "#{folder}##{file}"
      end
    end

    resources folder
  end

end
