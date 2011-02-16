class String
  def clean
    remove_tags.and_newlines.and_tabulations.and_double_spaces.and_last_space
  end

  protected

  def remove_tags
    gsub(/<\/.>|<.>/, "")
  end

  def and_newlines
    gsub(/\n/, " ")
  end

  def and_tabulations
    gsub(/\t/, " ")
  end

  def and_double_spaces
    gsub(/\s+/," ")
  end

  def and_last_space
    gsub(/\s$/, "")
  end
end
