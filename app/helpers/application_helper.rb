module ApplicationHelper
  def gulp_asset_path(path)
    path = REV_MANIFEST[path] if defined?(REV_MANIFEST)
    "/assets/#{path}"
  end

  def full_title(page_title = '')                     # Method def, optional arg
    base_title = "Your Sound In The Cloud"  # Variable assignment
    if page_title.empty?                              # Boolean test
      base_title                                      # Implicit return
    else
      page_title + " | " + base_title                 # String concatenation
    end
  end

end
