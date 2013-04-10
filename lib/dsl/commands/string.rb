class String
  def unindent_heredoc
    gsub(/^#{scan(/^\s*/).min_by{|l|l.length}}/, "")
  end
end
